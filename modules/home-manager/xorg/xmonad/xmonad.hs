#! /usr/bin/env runhugs +l
--
-- xmonad.hs
-- Copyright (C) 2018 evanjs <evanjs@asentoo>
--
-- Distributed under terms of the MIT license.
--

{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE StandaloneDeriving    #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE LambdaCase #-}
{-# OPTIONS -Wno-incomplete-patterns #-}

import Control.Monad ((>=>), join, liftM, when)
import Data.Maybe (maybeToList)

import Graphics.X11.ExtraTypes.XF86
import System.Exit
import System.IO
import System.Taffybar.Support.PagerHints (pagerHints)

import XMonad
import XMonad.Actions.DynamicWorkspaces as DynaW
import XMonad.Actions.Navigation2D
import XMonad.Actions.NoBorders
import XMonad.Actions.PhysicalScreens
import XMonad.Actions.SpawnOn
import XMonad.Actions.WorkspaceNames as WSN

import XMonad.Config.Desktop

import XMonad.Hooks.DynamicBars as Bars
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Script
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook

import XMonad.Layout.Accordion
import XMonad.Layout.Fullscreen
import XMonad.Layout.Grid as XG
import XMonad.Layout.GridVariants
import XMonad.Layout.IndependentScreens
import XMonad.Layout.NoBorders
import XMonad.Layout.PerScreen
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.Roledex
import XMonad.Layout.Tabbed
import XMonad.Layout.ToggleLayouts

import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run
import XMonad.Util.Scratchpad
import XMonad.Util.SpawnOnce
import XMonad.Util.WorkspaceCompare

import XMonad.Wallpaper

import qualified Data.Map                   as M
import qualified XMonad.Hooks.EwmhDesktops  as H
import qualified XMonad.Prompt              as P
import qualified XMonad.Actions.Submap      as SM
import qualified XMonad.Actions.Search      as S
import qualified XMonad.StackSet            as W
import qualified XMonad                     as X

import XMonad.Layout.MiddleColumn
import XMonad.Layout.WindowColumn
import XMonad.Layout.WindowColumn as Column (Column(..))
import XMonad.Util.WindowFinder
import XMonad.Actions.Submap
import XMonad.Layout.MasterOverlay
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Spacing
----------------------
-- helper functions --
----------------------
defaultThreeColumn :: (Float, Float, Float)
defaultThreeColumn = (0.15, 0.65, 0.2)

----------------------

myTerminal = "kitty"

-- The command to lock the screen or show the screensaver.
myLock = "slimlock"
myHalfLock = "xtrlock-pam"

-- The command to take a selective screenshot, where you select
-- what you'd like to capture on the screen.
mySelectScreenshot = "maim -s ~/shots/$(date +%Y-%m-%d_%T).png"

-- Take screenshot and copy to clipboard
myClipboardScreenshot = "maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png"

-- The command to take a fullscreen screenshot.
myScreenshot = "maim > ~/shots/$(date +%Y-%m-%d_%T).png"

myDelayedScreenshot = "maim -d3 ~/shots/$(date +%Y-%m-%d_%T).png"

myActiveWindowScreenshot = "maim -i $(xdotool getactivewindow) > ~/shots/$(date +%Y-%m-%d_%T).png"

-- The command to use as a launcher, to launch commands that don't have
-- preset keybindings.
myLauncher = "rofi -lines 7 -columns 2 -modi run -show"
mySshLauncher = "rofi -lines 7 -columns 2 -modi ssh -show"

myRandomWallpaper = "rrbg"

----------------
-- workspaces --
----------------
--myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"] ++ map show [11.999]

-- Workspaces with single-character names that can be keyed in with no modifiers.
simpleWorkspaces :: [X.WorkspaceId]
simpleWorkspaces = [[w] | w <- "1234567890-="]

kill8 ss | Just w <- W.peek ss = W.insertUp w $ W.delete w ss
  | otherwise = ss


------------
-- Search --
------------
searchEngineMap method = M.fromList $
    [ ((0, xK_g), method S.google)
    , ((0, xK_h), method S.hoogle)
    , ((0, xK_w), method S.wikipedia)
    ]

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
        ||| (SplitGrid XMonad.Layout.GridVariants.L 2 3 (2/3) (16/10) (5/100))
        ||| Accordion
        ||| XG.Grid
        ||| rTall
            where tall  = Tall 1 (3/100) (1/2) 
                  rTall = ResizableTall 1 (3/100) (1/2) []

chrissoundLayouts =
    desktopLayoutModifiers . smartBorders $
      mkToggle ((NOBORDERS ?? FULL ?? EOT)) (
        spacing 6 (ModifiedLayout (MasterOverlay Nothing) $ getMiddleColumnSaneDefault 2 0.2 defaultThreeColumn) |||
        spacing 6 (ModifiedLayout (MasterOverlay Nothing) $ getMiddleColumnSaneDefault 2 0.5 defaultThreeColumn) |||
        spacing 6 (ModifiedLayout (MasterOverlay Nothing) $ getMiddleColumnSaneDefault 3 0.75 (0.27333, 0.45333, 0.27333)) |||
        spacing 6 (ModifiedLayout (MasterOverlay Nothing) $ getMiddleColumnSaneDefault 3 0.75 (0.33333, 0.33333, 0.33333)) |||
        spacing 0 (noBorders (fullscreenFull Full)))

myLayouts = ifWider 3000 (genericLayouts ||| chrissoundLayouts) genericLayouts

------------------
-- window rules --
------------------
myManageHook = composeAll [
    className =? "Chromium" --> doShift "web"
  , className =? "Firefox"  --> doShift "web"
  , resource  =? "desktop_window" --> doIgnore
  , className =? "stalonetray"    --> doIgnore
  , isFullscreen --> doFullFloat
                          ]


addNETSupported :: Atom -> X ()
addNETSupported x   = withDisplay $ \dpy -> do
    r               <- asks theRoot
    a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
    a               <- getAtom "ATOM"
    liftIO $ do
       sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
       when (fromIntegral x `notElem` sup) $
         changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

addEWMHFullscreen :: X ()
addEWMHFullscreen   = do
    wms <- getAtom "_NET_WM_STATE"
    wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
    mapM_ addNETSupported [wms, wfs]

------------------
-- key bindings --
------------------

myModMask = mod4Mask

myKeys conf@XConfig {XMonad.modMask = modMask} = M.fromList $

  -- Start a terminal.  Terminal to start is specified by myTerminal variable.
  [ ((modMask .|. shiftMask, xK_Return),
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
    , ((modMask .|. shiftMask, xK_s),
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
    , ((mod2Mask .|. controlMask, xK_p),

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

    , ((modMask, xK_s), SM.submap $ searchEngineMap $ S.promptSearch P.def)
    , ((modMask .|. shiftMask, xK_s), SM.submap $ searchEngineMap $ S.selectSearch)

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
    , ((modMask, xK_n),
     refresh)

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

------------------
-- Startup hook --
------------------

myStartupHook :: X()
myStartupHook = do
    Bars.dynStatusBarStartup xmobarCreator xmobarDestroyer
    spawnOnce "taffybar"
    spawnOnce "autorandr -c && rrbg"


xmobarCreator :: Bars.DynamicStatusBar
xmobarCreator (S sid) = spawnPipe $ "xmobar -x " ++ show sid

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
renameWorkspace :: X.WorkspaceId -> X.X ()
renameWorkspace w = X.withWindowSet $ \ws -> do
  let c = W.tag . W.workspace . W.current $ ws
  DynaW.renameWorkspaceByName w
  -- Make sure that we're not left without one of the simple workspaces.
  when (c `elem` simpleWorkspaces) $ DynaW.addHiddenWorkspace c

------------
-- config --
------------
evanjsConfig = 
    H.ewmh $
    pagerHints $
    def {
      terminal    = "kitty"
    , manageHook  = manageDocks <+> myManageHook
    , modMask     = myModMask
    , logHook     = Bars.multiPP xmobarPP' xmobarPP'
    , layoutHook  = myLayouts
    , workspaces  = simpleWorkspaces
    , startupHook = myStartupHook >> addEWMHFullscreen
    , keys        = myKeys
    , handleEventHook = H.fullscreenEventHook
    }

main = do 
    --setRandomWallpaper ["/mnt/gentoo/usr/share/wallpapers/custom"]
    xmonad =<< xmobar evanjsConfig

