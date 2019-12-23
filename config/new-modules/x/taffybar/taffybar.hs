-- -*- mode:haskell -*-
{-# LANGUAGE OverloadedStrings #-}
module Main where
import Control.Monad
import Control.Monad.IO.Class
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Lazy.Char8 as Char8
import Data.Char (isSpace)
import qualified Data.Text as T
import qualified Graphics.UI.Gtk as G
import Control.Monad.Trans (liftIO)
--import System.Taffybar.Compat.GtkLibs
import System.Exit (ExitCode)
import System.IO (hPutStr, hClose)
import System.Process
import Data.IORef
import Text.Printf
import System.Taffybar
import qualified System.Taffybar.Context as C
import System.Taffybar.Hooks
import System.Taffybar.Information.CPU
import System.Taffybar.Information.Memory
import System.Taffybar.SimpleConfig
import System.Taffybar.Util (logPrintF)
import System.Taffybar.Widget
import System.Taffybar.Widget.Generic.PollingGraph
import System.Taffybar.Widget.Generic.PollingLabel
import System.Taffybar.Widget.Util
import System.Taffybar.Widget.Workspaces


transparent = (0.0, 0.0, 0.0, 0.0)
yellow1 = (0.9453125, 0.63671875, 0.2109375, 1.0)
yellow2 = (0.9921875, 0.796875, 0.32421875, 1.0)
green1 = (0, 1, 0, 1)
green2 = (1, 0, 1, 0.5)
taffyBlue = (0.129, 0.588, 0.953, 1)

myGraphConfig =
  defaultGraphConfig
  { graphPadding = 0
  , graphBorderWidth = 0
  , graphWidth = 75
  , graphBackgroundColor = transparent
  }

netCfg = myGraphConfig
  { graphDataColors = [yellow1, yellow2]
  , graphLabel = Just $ T.pack "net"
  }

memCfg = myGraphConfig
  { graphDataColors = [taffyBlue]
  , graphLabel = Just $ T.pack "mem"
  }

cpuCfg = myGraphConfig
  { graphDataColors = [green1, green2]
  , graphLabel = Just $ T.pack "cpu"
  }

-- TC: KTVC
-- Dowagiac: KBEH
wcfg = (defaultWeatherConfig "KTVC") { weatherTemplate = "$stationPlace$ : $tempF$ F / $tempC$ C - $skyCondition$" }

memCallback :: IO [Double]
memCallback = do
  mi <- parseMeminfo
  return [memoryUsedRatio mi]

cpuCallback = do
  (_, systemLoad, totalLoad) <- cpuLoad
  return [totalLoad, systemLoad]

{-shellWidgetTooltipNew :: String -> String -> String -> Double -> C.TaffyIO G.Widget-}
{-shellWidgetTooltipNew defaultStr cmd tooltipCmd interval = do-}
  {-mString <- readCreateProcess (shell cmd) ""-}
  {-tString <- readCreateProcess (shell tooltipCmd) ""-}
  {-{-liftIO $ mString-}-}
  {-{-liftIO $ tString-}-}
  {-label <- pollingLabelNewWithTooltip defaultStr interval $ return (mString, Just tString)-}
  {-liftIO $ G.widgetShowAll $ label-}
  {-return label-}

{-shellWidgetNew defaultStr cmd interval = do-}
  {-label <- pollingLabelNew defaultStr interval $ T.unpack (T.pack( readCreateProcess (shell cmd) "" ))-}
  {-liftIO $ G.widgetShowAll $ label-}

  {-return label-}

{-cmdThing :: T.Text -> T.Text-}
{-cmdThing :: String -> String-}
{-cmdThing :: String -> String-}
{-cmdThing cmd = do-}
    {-liftIO $ stripStr $ readCreateProcess (shell cmd) ""-}
    

{-download url = do-}
   {-doc <- openURI url-}
   {-Just doc-}

{-shellWidgetNewTooltip :: String -> String -> Double -> C.TaffyIO G.Widget-}
{-shellWidgetNewTooltip title cmd interval = do-}
  {-theTip <- stripStr $ readCreateProcess (shell cmd) ""-}
  {-label <- pollingLabelNewWithTooltip title interval $ return (title, Just theTip)-}
  {-liftIO $ G.widgetShowAll $ label-}

  {-return label-}

{-getDoc :: Maybe String -> String -> IO (Either String)-}
{-getDoc url = do-}
  {-dat <- downloadURL url-}
  {-case dat of-}
    {-Right dat' -> case parse parseData url dat' of-}
      {-Right d -> return (Right d)-}
      {-Left err -> return (Left (show err))-}
    {-Left err -> return (Left (show err))-}


{-getCurrentWttr :: IO (Either String)-}
    {--> StringTemplate String-}
    {--> StringTemplate String-}
    {--> IO (T.Text, Maybe T.Text)-}
{-getCurrentWttr labelTpl tooltipTpl = do-}
  {-dat <- getDoc "wttr.in"-}
    {-case dat of-}
      {-Right wi ->-}
        {-case formatter of-}
          {-String f -> do-}
            {-let rawLabel <- T.pack $ f wi-}
            {-lbl <- markupEscapeText rawLabel (fromIntegral $ T.length rawLabel)-}
            {-return (lbl, Just lbl)-}
      {-Left err -> do-}
        {-putStrLn err-}
        {-return ("N/A", Nothing)-}

{-weatherTooltipNew' labelTpl tooltipTpl = liftIO $ do-}
  {-let labelTpl' = newSTMP "aaa"-}
      {-tooltipTpl' = newSTMP "bbb"-}

  {-l <- pollingLabelNewWithTooltip "Can't retrieve tooltip"-}
  {-(getCurrentWttr labelTpl' tooltipTpl')-}

  {-GI.Gtk.WidgetShowAll l-}
  {-return l-}

stripStr :: IO String -> IO String
stripStr ioString = do
  str <- ioString
  return $ rstrip $ str

rstrip = reverse . dropWhile isSpace . reverse


main = do
  let myWorkspacesConfig =
        defaultWorkspacesConfig
        { minIcons = 1
        , widgetGap = 0
        , showWorkspaceFn = hideEmpty
        }
      workspaces = workspacesNew myWorkspacesConfig
      cpu = pollingGraphNew cpuCfg 0.5 cpuCallback
      mem = pollingGraphNew memCfg 1 memCallback
      net = networkGraphNew netCfg Nothing
      clock = textClockNew Nothing "%a %b %_d %r" 1
      layout = layoutNew defaultLayoutConfig
      windows = windowsNew defaultWindowsConfig
      {-texxxt =  liftIO $ cmdThing "eix -u# wc -l"-}
      {-updates = commandRunnerNew 10 "echo" ["-e", "Updates:", texxxt] (T.pack "Failed to fetch updates")-}
      {-updates = commandRunnerNew 10 "echo" ["-e", "Updates: $(eix -u# | wc -l)"] (T.pack "Failed to fetch updates")-}
      updates = commandRunnerNew 10 "ecount" [] (T.pack "can't query updates")
      {-wttr = commandRunnerNew 10 "curl" ["http://wttr.in"] (T.pack "no wttr")-}
      {-updates = shellWidgetNew (T.pack "...") "echo -e \"Updates: $(eix -u# | wc -l)\"" 5-}
      {-kernel = shellWidgetNew (T.pack "...") "echo -e \"Cur: $(uname -r)\"" 86400 -}
      newKernel = commandRunnerNew 1800 "newkern" [] (T.pack "?.?.?")
      {-wttr = pollingLabelNewWithTooltip "..." "echo ..." "wttrt" 20-}
      {-wttr = pollingLabelNewWithTooltip (T.pack "nothing") 10 $ (, Nothing) <$> "wttrt"-}
      {-wttr = shellWidgetNewTooltip "..." "curl wttr.in" 20-}
      {-wttr = return shellWidgetTooltipNew "..." "echo ..." "curl wttr.in" 20-}
      {-wttr = pollingLabelNewWithTooltip " ... " 10 $ return ("...", Just ( liftIO $ openURI "wttr.in"))-}
      {-wttr = weatherTooltipNew'-}
      weather = liftIO $ weatherNew wcfg 30
          -- See https://github.com/taffybar/gtk-sni-tray#statusnotifierwatcher
          -- for a better way to set up the sni tray
      tray = sniTrayThatStartsWatcherEvenThoughThisIsABadWayToDoIt


      myConfig = defaultSimpleTaffyConfig
        { startWidgets =
            workspaces : map (>>= buildContentsBox) [ layout, windows ]
        , endWidgets = map (>>= buildContentsBox)
          [ 
            {-batteryIconNew ,-}
	    clock
          , tray
          , cpu
          , mem
          , net
          {-, mpris2New-}
          , updates
          {-, wttr-}
          {-, kernel-}
          , newKernel
          , weather
          ]
        , barPosition = Top
        , barPadding = 10
        , barHeight = 50
        , widgetSpacing = 8
        }
  {-startTaffybar $ withBatteryRefresh $ withLogServer $ withToggleServer $-}
  startTaffybar $ withLogServer $ withToggleServer $
               toTaffyConfig myConfig
