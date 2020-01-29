#! /usr/bin/env runhugs +l
--
-- xmonad.hs
-- Copyright (C) 2020 evanjs <evanjsx@gmail.com>
--
-- Distributed under terms of the MIT license.
--

{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS -Wno-incomplete-patterns #-}

import           Control.Monad                       (forM_, join, liftM, when,
                                                      (>=>))
import           Data.Maybe                          (maybeToList)
import           Data.Monoid

import           Graphics.X11.ExtraTypes.XF86
import           System.Exit
import           System.IO
import           System.Taffybar.Support.PagerHints  (pagerHints)

import           XMonad
import           XMonad.Actions.CycleWS
import           XMonad.Actions.DynamicWorkspaces    as DynaW
import           XMonad.Actions.GroupNavigation
import           XMonad.Actions.Navigation2D
import           XMonad.Actions.NoBorders
import           XMonad.Actions.PhysicalScreens
import           XMonad.Actions.ShowText
import           XMonad.Actions.SpawnOn
import           XMonad.Actions.Submap
import           XMonad.Actions.WorkspaceNames       as WSN

import           XMonad.Config.Desktop

import           XMonad.Hooks.DynamicBars            as Bars
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.FadeInactive
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.Place
import           XMonad.Hooks.Script
import           XMonad.Hooks.SetWMName
import           XMonad.Hooks.UrgencyHook

import           XMonad.Layout.Fullscreen
import           XMonad.Layout.Grid                  as XG
import           XMonad.Layout.GridVariants
import           XMonad.Layout.IndependentScreens
import           XMonad.Layout.LayoutModifier
import           XMonad.Layout.MultiToggle
import           XMonad.Layout.MultiToggle.Instances
import           XMonad.Layout.NoBorders
import           XMonad.Layout.PerScreen
import           XMonad.Layout.PerWorkspace
import           XMonad.Layout.ResizableTile
import           XMonad.Layout.Spacing
import           XMonad.Layout.Tabbed
import           XMonad.Layout.ToggleLayouts

import           XMonad.ManageHook

import           XMonad.Prompt.Man

import           XMonad.Util.EZConfig                (additionalKeys)
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.Run
import           XMonad.Util.Scratchpad
import           XMonad.Util.SpawnOnce
import           XMonad.Util.WindowProperties
import           XMonad.Util.WorkspaceCompare

import qualified Data.Map                            as M
import qualified Data.Set                            as S

import qualified XMonad.Actions.Search               as Search
import qualified XMonad.Actions.Submap               as SM
import qualified XMonad.Hooks.EwmhDesktops           as H
import qualified XMonad.Prompt                       as P
import qualified XMonad.StackSet                     as W
import qualified XMonad.Util.ExtensibleState         as XS

----------------------
-- helper functions --
----------------------
defaultThreeColumn :: (Float, Float, Float)
defaultThreeColumn = (0.15, 0.65, 0.2)

----------------------

myBrowser = "chromium-browser"
myTerminal = "kitty"

-- The command to lock the screen or show the screensaver.
myLock = "slimlock"
myHalfLock = "xtrlock-pam"

-- The command to take a selective screenshot, where you select
-- what you'd like to capture on the screen.
mySelectScreenshot = "@selectScreenshotCmd@"

-- Take screenshot and copy to clipboard
myClipboardScreenshot = "@clipboardScreenshotCmd@"

-- The command to take a fullscreen screenshot.
myScreenshot = "@screenshotCmd@"

myDelayedScreenshot = "@delayedScreenshotCmd@"

myActiveWindowScreenshot = "@activeWindowScreenshotCmd@"

-- The command to use as a launcher, to launch commands that don't have
-- preset keybindings.
myLauncher = "rofi -lines 7 -columns 2 -modi run -show"
mySshLauncher = "rofi -lines 7 -columns 2 -modi ssh -show"

myRandomWallpaper = "rrbg"

myScratchpads = [
    NS "htop" "kitty --name=scratch-htop htop" (appName =? "scratch-htop") doCenterFloat,
    NS "terminal" "kitty --name=scratch-terminal" (appName =? "scratch-terminal") doCenterFloat,
    NS "notes" "emacsclient -ne '(progn (select-frame (list (cons (quote name) \"*Notes*\") (cons (quote desktop-dont-save) t)))) (deft))'" (name =? "*Notes*") nonFloating,
    NS "zeal" "@zeal@" (className =? "Zeal") doCenterFloat
    ]
  where
      name = stringProperty "WM_NAME"

scratchPadName = "NSP"

nonScratchPad :: WSType
nonScratchPad = WSIs $ return ((scratchPadName /=) . W.tag)

switchOtherWindow :: Direction -> X ()
switchOtherWindow direction = do
    name <- getCurrentClassName
    nextMatch direction (className =? name)

showTextConfig :: ShowTextConfig
showTextConfig = def
    { st_font = "xft:fira-code" }
----------------
-- workspaces --
----------------
myWorkspaces = ["web", "emacs", "dev", "debug", "terminal", "vm"] ++ map show [7..8] ++ ["git", "chat"]

kill8 ss | Just w <- W.peek ss = W.insertUp w $ W.delete w ss
  | otherwise = ss


------------
-- Search --
------------
searchEngineMap method = M.fromList
    [ ((0, xK_a), method Search.alpha)
    , ((0, xK_i), method Search.imdb)
    -- see if we can use searchEngineF (params: character, anime, manga, etc) to make this more concise
    , ((0, xK_c), method myanimelistchara)
    , ((0, xK_m), method myanimelist)
    , ((0, xK_z), method amazon)
    , ((0, xK_g), method Search.google)
    , ((0, xK_h), method hoogle)
    , ((0, xK_l), method lhoogle)
    , ((0, xK_w), method Search.wikipedia)
    ]
        where
            -- use new hoogle site
            hoogle            = Search.searchEngine "hoogle"                  "https://hoogle.haskell.org/?q="
            lhoogle           = Search.searchEngine "local hoogle"            "http://localhost:8471/?q="
            githubRust        = Search.searchEngine "github rust"             "https://github.com/search?l=Rust&p=2&type=Code&q="
            myanimelist       = Search.searchEngine "myanimelist"             "https://myanimelist.net/anime.php?q="
            amazon            = Search.searchEngine "amazon"                  "https://www.amazon.com/s?k="
            myanimelistchara  = Search.searchEngine "myanimelist characters"  "https://myanimelist.net/character.php?q="

------------------------------------------------------------------------
    --gaps, etc
------------------------------------------------------------------------
  --mySpacing             = spacing gap
  --sGap                  = quot gap 2
  --myGaps                = gaps [(U, gap),(D, gap),(L, gap),(R, gap)]
  --mySmallGaps           = gaps [(U, sGap),(D, sGap),(L, sGap),(R, sGap)]
  --myBigGaps             = gaps [(U, gap*2),(D, gap*2),(L, gap*2),(R, gap*2)]


-------------
-- layouts --
-------------
tabbedLayout = tabbed shrinkText tabbedConf

tabbedConf = def
    {
    fontName = "xft:fira-code"
    }

genericLayouts =
    avoidStruts $ smartBorders $
        tall
        ||| Mirror tall
        ||| tabbedLayout
        ||| noBorders (fullscreenFull Full)
        ||| SplitGrid XMonad.Layout.GridVariants.L 2 3 (2/3) (16/10) (5/100)
        ||| XG.Grid
        ||| rTall
            where tall  = Tall 1 (3/100) (1/2)
                  rTall = ResizableTall 1 (3/100) (1/2) []

myLayouts = genericLayouts

------------------
-- window rules --
------------------
myManageHook :: ManageHook
myManageHook = composeOne [
    isDialog                                  -?> doFloat
  , isFullscreen                              -?> doFullFloat
  , name            =? "Open Files"           -?> doCenterFloat
  , name            =? "File Upload"          -?> doCenterFloat
  , name            =? "Save As"              -?> doCenterFloat
  , name            =? "scratch-htop"         -?> idHook
  , name            =? "scratch-terminal"     -?> idHook
  , name            =? "*Notes*"              -?> idHook
  , resource        =? "file_properties"      -?> doCenterFloat
  , resource        =? "Dialog"               -?> doFloat
  , className       =? "Display"              -?> doCenterFloat
  , className       =? "Chromium-browser"     -?> doShift "web"
  , className       =? "Firefox"              -?> doShift "web"
  , className       =? "kitty"                -?> doShift "terminal"
  , className       =? "GitKraken"            -?> doShift "git"
  , className       =? "Slack"                -?> doShift "chat"
  , className       =? "jetbrains"            -?> doShift "dev"
  , className       =? "Emacs"                -?> doShift "emacs"
  , isNotification                            -?> doIgnore
  ]
  where
      name = stringProperty "WM_NAME"

------------------
-- key bindings --
------------------

myModMask = mod4Mask

myKeys conf@XConfig {XMonad.modMask = modMask} = M.fromList $

  [

  -- Launch emacs
  ((modMask .|. controlMask, xK_e),
  spawn "@emacs@")

  -- Start a terminal.  Terminal to start is specified by myTerminal variable.
    ,((modMask .|. shiftMask, xK_Return),
    spawn $ XMonad.terminal conf)

  -- Lock the screen using command specified by myLock.
    , ((modMask .|. controlMask, xK_l),
     spawn myLock)

  -- Lock the screen using command specified by myHalfLock
    , ((modMask .|. controlMask, xK_x),
     spawn myHalfLock)

  -- Spawn the launcher using command specified by myLauncher.
  -- Use this to launch programs without a key binding.
    , ((modMask, xK_p),
     spawn myLauncher)
  -- Spawn the launcher using command specified by myLauncher.
  -- Use this to launch programs without a key binding.
    , ((modMask .|. shiftMask, xK_h),
     spawn mySshLauncher)
  -- Take a selective screenshot using the command specified by mySelectScreenshot.
    , ((modMask .|. shiftMask, xK_p),
     spawn mySelectScreenshot)
  -- Take a full screenshot using the command specified by myScreenshot.
    --, ((modMask .|. controlMask .|. shiftMask, xK_p),
    , ((modMask, xK_Print),
     spawn myScreenshot)
  -- Take a full screenshot using the command specified by myScreenshot - with a delay.
    , ((modMask .|. controlMask .|. shiftMask, xK_l),
     spawn myDelayedScreenshot)
  -- Take a screenshot of the current window and save it to the clipboard using the command specified by myClipboardScreenshot.
    , ((modMask .|. controlMask .|. shiftMask, xK_c),
     spawn myClipboardScreenshot)
  -- Take a screenshot of the current window
    , ((mod4Mask .|. controlMask, xK_p),
    spawn myActiveWindowScreenshot)
  ---------------------------------------------------------------------------
  -- Media Key Shortcuts
  ---------------------------------------------------------------------------
    , ((0, xF86XK_AudioLowerVolume   ), spawn "amixer -q set Master 1%-")
    , ((0, xF86XK_AudioRaiseVolume   ), spawn "amixer -q set Master 1%+")
    , ((0, xF86XK_AudioMute          ), spawn "amixer -q set Master toggle")
  ---------------------------------------------------------------------------
  -- Mute volume.
    , ((modMask .|. controlMask, xK_m),
     spawn "amixer -q set Master toggle")
  -- Decrease volume.
    , ((modMask .|. controlMask, xK_j),
     spawn "amixer -q set Master 5%-")
  -- Increase volume.
    , ((modMask .|. controlMask, xK_k),
     spawn "amixer -q set Master 5%+")
  -- Audio previous.
    , ((0, 0x1008FF16),
     spawn "")
  -- Play/pause.
    , ((0, 0x1008FF14),
     spawn "")
  -- Audio next.
    , ((0, 0x1008FF17),
     spawn "")
  -- Eject CD tray.
    , ((0, 0x1008FF2C),
     spawn "eject -T")
  -- Randomize Wallpaper
    , ((modMask .|. controlMask .|. shiftMask, xK_r),
    spawn myRandomWallpaper)

    , ((modMask, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 1")
    , ((modMask, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 1")
    , ((modMask .|. shiftMask, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 10")
    , ((modMask .|. shiftMask, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 10")

    , ((modMask, xK_s), SM.submap $ searchEngineMap $ Search.promptSearchBrowser' P.def myBrowser)
    , ((modMask .|. shiftMask, xK_s), SM.submap $ searchEngineMap (Search.selectSearchBrowser myBrowser))

--------------------------------------------------------------------
    -- "Standard" xmonad key bindings
--

  -- Close focused window.
    , ((modMask .|. shiftMask, xK_c),
     kill)

  -- Cycle through the available layout algorithms.
    , ((modMask, xK_space),
     sendMessage NextLayout)

  --  Reset the layouts on the current workspace to default.
    , ((modMask .|. shiftMask, xK_space),
     setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size.
    --, ((modMask, xK_n),
     -- refresh)

  -- Move focus to the next window.
    , ((modMask, xK_Tab),
     windows W.focusDown)

  -- Move focus to the next window.
    , ((modMask, xK_j),
     windows W.focusDown)

  -- Move focus to the previous window.
    , ((modMask, xK_k),
     windows W.focusUp  )

  -- Move focus to the master window.
    , ((modMask, xK_m),
     windows W.focusMaster  )

  -- Swap the focused window and the master window.
    , ((modMask, xK_Return),
     windows W.swapMaster)

  -- Swap the focused window with the next window.
    , ((modMask .|. shiftMask, xK_j),
     windows W.swapDown  )

  -- Swap the focused window with the previous window.
    , ((modMask .|. shiftMask, xK_k),
     windows W.swapUp    )

  -- Shrink the master area.
    , ((modMask, xK_h),
     sendMessage Shrink)

  -- Expand the master area.
    , ((modMask, xK_l),
     sendMessage Expand)

  -- Push window back into tiling.
    , ((modMask, xK_t),
     withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
    , ((modMask, xK_comma),
     sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
    , ((modMask, xK_period),
     sendMessage (IncMasterN (-1)))

  -- Toggle the status bar gap.
  -- TODO: update this binding with avoidStruts, ((modMask, xK_b),

  -- Quit xmonad.
    , ((modMask .|. shiftMask, xK_q),
     io exitSuccess)

  -- Restart xmonad.
    , ((modMask, xK_q),
     restart "xmonad" True)

  -- switch between dynamic workspaces
    , ((modMask, xK_v), selectWorkspace def)

  -- toggle fullscreen
    , ((modMask .|. shiftMask, xK_f), sendMessage ToggleStruts)

  -- rename workspace
    , ((modMask .|. shiftMask, xK_r), WSN.renameWorkspace def)

    , ((modMask, xK_Left),   sendMessage MirrorExpand)
    , ((modMask, xK_Up),     sendMessage MirrorExpand)
    , ((modMask, xK_Right),  sendMessage MirrorShrink)
    , ((modMask, xK_Down),   sendMessage MirrorShrink)

    , ((modMask, xK_F1), manPrompt P.def)

    , ((modMask,                                      xK_bracketleft), moveTo Prev nonScratchPad)
    , ((modMask,                                      xK_bracketright), moveTo Next nonScratchPad)

    , ((modMask .|. shiftMask,                        xK_bracketleft), moveTo Prev nonScratchPad)
    , ((modMask .|. shiftMask,                        xK_bracketright), shiftTo Next nonScratchPad)

    , ((modMask .|. shiftMask .|. controlMask,        xK_bracketleft), shiftTo Prev nonScratchPad >> moveTo Prev nonScratchPad)
    , ((modMask .|. shiftMask .|. controlMask,        xK_bracketright), shiftTo Next nonScratchPad >> moveTo Next nonScratchPad)

    , ((modMask,                                      xK_b), toggleWS' [scratchPadName])

    -- Applications
    , ((modMask .|. controlMask,                      xK_h), namedScratchpadAction myScratchpads "htop")
    , ((modMask .|. controlMask,                      xK_t), namedScratchpadAction myScratchpads "terminal")
    , ((modMask .|. controlMask,                      xK_z), namedScratchpadAction myScratchpads "zeal")

    , ((modMask,                                      xK_asciitilde), switchOtherWindow Backward)
    , ((modMask,                                      xK_grave), switchOtherWindow Forward)
    , ((modMask,                                      xK_Tab), nextMatch Backward (return True))
    , ((modMask,                                      xK_Tab), nextMatch Forward (return True))

  -- get the class name of the focused window
  -- this can be useful for things like picom/compton opacity rules
    , ((modMask, xK_F4), getCurrentClassName >>= flashText showTextConfig 1)
  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

  ++

  [((m.|. modMask, k), f sc)
    | (k, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    , (f, m) <- [(viewScreen def, 0), (sendToScreen def, shiftMask)]]


getCurrentClassName = withWindowSet $ \set -> case W.peek set of
    Just window -> runQuery className window
    Nothing     -> return ""

newtype NotificationWindows = NotificationWindows (S.Set Window) deriving (Read, Show, Typeable)
instance ExtensionClass NotificationWindows where
    initialValue = NotificationWindows S.empty
    extensionType = PersistentExtension

-- Check if window has the given property of type Atom
hasAtomProperty :: Window -> String -> String -> X Bool
hasAtomProperty window property value = do
    valueAtom <- getAtom value
    property <- getProp32s property window
    return $ case property of
               Just values -> fromIntegral valueAtom `elem` values
               _           -> False

-- Keep track of notification windows
trackNotificationWindowsHook :: Event -> X All
trackNotificationWindowsHook MapNotifyEvent {ev_window = window} = do
    NotificationWindows windows <- XS.get
    isNotification <- hasAtomProperty window "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_NOTIFICATION"

    -- when this is a notification window remember it
    when isNotification $ XS.put (NotificationWindows (S.insert window windows))

    return $ All True

trackNotificationWindowsHook UnmapEvent {ev_window = window} = do
    NotificationWindows windows <- XS.get

    -- Window unmapped -- forget it
    XS.put (NotificationWindows (S.delete window windows))

    return $ All True

trackNotificationWindowsHook _ = return $ All True

isNotification = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_DIALOG"


keepFloatsOnTopHook :: X ()
keepFloatsOnTopHook = do
    windowSet <- gets windowset
    notificationWindows <- XS.get :: X NotificationWindows

    let
        raiseWindowMaybe windowSet window =
            (when (M.member window $ W.floating windowSet) $ withDisplay $ \display -> io $ raiseWindow display window)
        in
        forM_ (W.peek windowSet) (raiseWindowMaybe windowSet)

myFadeHook :: X ()
myFadeHook =
    fadeOutLogHook $ fadeIf (isUnfocused <&&> fmap not shouldNotFade) 0.8
        where
            shouldNotFade = isNotification

------------------
-- Startup hook --
------------------

myStartupHook :: X()
myStartupHook = do
    Bars.dynStatusBarStartup xmobarCreator xmobarDestroyer
    spawnOnce "autorandr -c && rrbg"


xmobarCreator :: Bars.DynamicStatusBar
xmobarCreator (S sid) = spawnPipe $ "@xmobar@ -x " ++ show sid

xmobarDestroyer :: Bars.DynamicStatusBarCleanup
xmobarDestroyer = return ()

--------------------------------------------
xmobarPP' = xmobarPP {
  ppSort = mkWsSort $ getXineramaPhysicalWsCompare def
}
  where dropIx wsId = if ':' `elem` wsId then drop 2 wsId else wsId
---------------------------------------------------
-- Rename the workspace and do some bookkeeping. --
---------------------------------------------------
renameWorkspace :: WorkspaceId -> X ()
renameWorkspace w = withWindowSet $ \ws -> do
  let c = W.tag . W.workspace . W.current $ ws
  DynaW.renameWorkspaceByName w
  -- Make sure that we're not left without one of the workspaces
  when (c `elem` myWorkspaces) $ DynaW.addHiddenWorkspace c

------------
-- config --
------------
evanjsConfig =
    H.ewmh $
    pagerHints $
    def {
      terminal    = myTerminal
    , manageHook  = manageSpawn <+> namedScratchpadManageHook myScratchpads <+> placeHook placementPreferCenter <+> myManageHook <+> manageDocks
    , modMask     = myModMask
    , logHook     = historyHook <+> myFadeHook <+> keepFloatsOnTopHook <+> H.ewmhDesktopsLogHookCustom namedScratchpadFilterOutWorkspace <+> Bars.multiPP xmobarPP' xmobarPP'
    , layoutHook  = myLayouts
    , workspaces  = myWorkspaces
    , startupHook = myStartupHook
    , keys        = myKeys
    , handleEventHook = H.fullscreenEventHook <+> trackNotificationWindowsHook <+> handleTimerEvent
    }
        where
            placementPreferCenter = withGaps (16,0,16,0) (smart (0.5,0.5))

main = xmonad $ docks evanjsConfig
