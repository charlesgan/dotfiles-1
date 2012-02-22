-- Imports {{{


import System.Exit

import XMonad
import XMonad.Layout
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.PerWorkspace
import XMonad.Layout.LayoutHints
import XMonad.Layout.ThreeColumns

import XMonad.Layout
import XMonad.Layout.ResizableTile
import XMonad.Layout.StackTile
import XMonad.Layout.IM
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Reflect
import XMonad.Layout.Combo
import XMonad.Layout.TwoPane
import XMonad.Layout.WindowNavigation


import XMonad.Hooks.ManageDocks

import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog   (PP(..), dynamicLogWithPP, wrap, defaultPP)
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops 
import XMonad.Util.Run (spawnPipe)
import qualified XMonad.StackSet as W
import qualified Data.Map as M

import XMonad.Actions.GridSelect
     
import System.IO (hPutStrLn)
-- }}}
 
-- Control Center {{{
-- Colour scheme {{{
myNormalBGColor     = "#262729"
myFocusedBGColor    = "#414141"
myNormalFGColor     = "#a1a1a1"
myFocusedFGColor    = "#cccccc"
myBorderColor	    = "#FF350D"
--myBorderColor = "#000000"
myUrgentFGColor     = "#ff0000"
myUrgentBGColor     = myNormalBGColor
mySeperatorColor    = "#2e3436"
-- }}}

-- Icon packs can be found here:
-- http://robm.selfip.net/wiki.sh/-main/DzenIconPacks
myBitmapsDir        = "/home/yigit/.share/icons/dzen"
myFont              = "-*-terminus-medium-*-*-*12-*-*-*-*-*-u"
myxftFont	    = "xft:Sans:pixelsize=8"
-- }}}

-- Workspaces {{{
myWorkspaces :: [WorkspaceId]
myWorkspaces = ["www", "general", "chat", "music", "code" ,"remote", "transmission", "8", "9"] 
-- }}}
 
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
 
    -- launch dmenu
    , ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu -nb darkred -nf black -sf black -sb darkorange -fn -*-terminus-medium-*-*-*-14-*-*-*-*-*-iso8859-1` && eval \"exec $exe\"") 
    -- close focused window 
    , ((modm .|. shiftMask, xK_c     ), kill)
 
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

--    , ((modm, xK_Caps_Lock), sendMessage $ Toggle FULL) 
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
 
    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
 
    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )
 
    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)
 
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
 
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
 
    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)
 
    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)
 
    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
 
    -- toggle the status bar gap (used with avoidStruts from Hooks.ManageDocks)
    -- , ((modm , xK_b ), sendMessage ToggleStruts)
 
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- XF86KbdBrightnessUp
    , ((0 , 0x1008ff02), spawn "/home/yigit/.scripts/brightnessinc")
    -- XF86KbdBrightnessDown
    , ((0 , 0x1008ff03), spawn "/home/yigit/.scripts/brightnessdec")

    , ((modm , xK_i), spawn "/home/yigit/.scripts/brightnessinc")
    , ((modm , xK_d), spawn "/home/yigit/.scripts/brightnessdec")


    -- XF86AudioMute
    , ((0 , 0x1008ff12), spawn "amixer -q set Master toggle")
    -- XF86AudioMedia
    , ((0 , 0x1008ff32), spawn "amixer -q set Master toggle")

    -- XF86AudioLowerVolume
    , ((0 , 0x1008ff11), spawn "amixer -q set Master 1- unmute")
    -- XF86AudioRaiseVolume
    , ((0 , 0x1008ff13), spawn "amixer -q set Master 1+ unmute")
    --XF86Launch1 :1008FF41
    -- , ((0 , 0x1008FF41), spawn "rhythmbox")
    

    , ((0 , 0x1008FF41), spawn "/opt/google/chrome/google-chrome '--app=http://music.google.com/music/listen'")


    -- Absolute Radio
    , ((modm,               xK_a     ), spawn "rhythmbox-client --play-uri http://mp3-vr-128.as34763.net:80/")
    -- Chrome
    , ((modm,               xK_c     ), spawn "google-chrome --ignore-gpu-blacklist")

    -- Chrome
    , ((modm,               xK_m     ), spawn "/home/yigit/programlar/minecraft")

 
    -- Restart xmonad
    , ((modm              , xK_q     ), restart "xmonad" True)

    -- GridSelect
--    , ((modm, xK_g), goToSelected defaultGSConfig)
    
   -- Combined Layout
    , ((modm,                 xK_Right), sendMessage $ Go R)
    , ((modm,                 xK_Left ), sendMessage $ Go L)
    , ((modm,                 xK_Up   ), sendMessage $ Go U)
    , ((modm,                 xK_Down ), sendMessage $ Go D)
    , ((modm .|. controlMask, xK_Right), sendMessage $ Swap R)
    , ((modm .|. controlMask, xK_Left ), sendMessage $ Swap L)
    , ((modm .|. controlMask, xK_Up   ), sendMessage $ Swap U)
    , ((modm .|. controlMask, xK_Down ), sendMessage $ Swap D)
    ]
    ++
 
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
 
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
 
statusBarCmd= "dzen2 -p -h 16 -ta l -bg '" ++ myNormalBGColor ++ "' -fg '" ++ myNormalFGColor ++ "' -w 900 -sa c -fn '" ++ myFont ++ "'"

myTopBar = "conky -c /home/yigit/.conkytop | dzen2 -x '900' -y '0' -h '16' -w '640' -ta 'r' -fg '" ++ myNormalFGColor ++ "' -bg '" ++ myNormalBGColor ++ "' -fn '" ++ myFont ++ "' " 
myTimeBar = "conky -c /home/yigit/.conkysaat | dzen2 -x '1550' -y '0' -h '18' -w '50' -ta 'r' -fg '" ++ myNormalFGColor ++ "' -bg '" ++ myNormalBGColor ++ "' -fn '" ++ myFont ++ "' "
 
-- Main {{{
main = do
    statusBarPipe <- spawnPipe statusBarCmd
    conkytop <- spawnPipe myTopBar
    xmonad $ withUrgencyHook NoUrgencyHook $defaultConfig {
        modMask = mod4Mask,
        borderWidth = 1,
        --terminal = "urxvtc -imlocale en-US.UTF-8",
        terminal = "gnome-terminal",
	normalBorderColor = myNormalBGColor,
        focusedBorderColor = myBorderColor,
        --defaultGaps = [(16,0,0,0)],
        manageHook = manageHook defaultConfig <+> myManageHook,
--	handleEventHook    = fullscreenEventHook, 
        layoutHook = smartBorders(globalLayout),
        workspaces = myWorkspaces,
        logHook = dynamicLogWithPP $ myPP statusBarPipe,
        keys = myKeys,
	startupHook = setWMName "LG3D"
    }
    where
        globalLayout =  avoidStruts (tiled ||| Mirror tiled ||| Full ||| threeColMid ||| combine) ||| Full

        tiled = ThreeCol 1 (3/100) (1/3)
        threeColMid =  ThreeColMid 1 (50/100) (1/3) 
        combine = combineTwo (TwoPane 0.5 0.5) (tiled) (tiled)
-- }}}
 
-- Window rules (floating, tagging, etc) {{{
myManageHook = composeAll [
        className   =? "google-chrome"       --> doF(W.shift "www"),
        className   =? "Pidgin"              --> doF(W.shift "chat"),
        className   =? "Gwibber"             --> doF(W.shift "chat"),
        className   =? "Empathy"             --> doF(W.shift "chat"),
        className   =? "Rhythmbox"           --> doF(W.shift "music"),
	className   =? "Transmission"        --> doF(W.shift "transmission"),
        className   =? "Skype"               --> doF(W.shift "chat"),
        className   =? "Trayer"              --> doIgnore,
	className 	=? "Panel"				 --> doIgnore,
	className 	=? "Tasque"				 --> doF(W.shift "todo"),

	resource 	=? "trayer" 			 --> doIgnore,
	resource 	=? "teeworlds" 			 --> doIgnore,

		isFullscreen   						 --> doFullFloat
    ]
-- }}}
 
-- Dzen Pretty Printer {{{
-- Stolen from Rob [1] and modified
-- [1] http://haskell.org/haskellwiki/Xmonad/Config_archive/Robert_Manea%27s_xmonad.hs
myPP handle = defaultPP {
        ppCurrent = wrap ("^fg(" ++ myFocusedFGColor ++ ")^bg(" ++ myFocusedBGColor ++ ")^p(4)") "^p(4)^fg()^bg()",
        ppUrgent = wrap ("^fg(" ++ myUrgentFGColor ++ ")^bg(" ++ myUrgentBGColor ++ ")^p(4)") "^p(4)^fg()^bg()",
        ppVisible = wrap ("^fg(" ++ myNormalFGColor ++ ")^bg(" ++ myNormalBGColor ++ ")^p(4)") "^p(4)^fg()^bg()",
        ppSep     = "^fg(" ++ mySeperatorColor ++ ")^r(3x3)^fg()",
        ppLayout  = (\x -> case x of
                    "Tall"          -> " ^i(" ++ myBitmapsDir ++ "/tall.xbm) "
                    "Mirror Tall"   -> " ^i(" ++ myBitmapsDir ++ "/mtall.xbm) "
                    "Full"          -> " ^i(" ++ myBitmapsDir ++ "/full.xbm) "
                    "ThreeCol"      -> " ^i(" ++ myBitmapsDir ++ "/threecol.xbm) "
                    "Hinted Tall"          -> " ^i(" ++ myBitmapsDir ++ "/tall.xbm) "
                    "Hinted Mirror Tall"   -> " ^i(" ++ myBitmapsDir ++ "/mtall.xbm) "
                    "Hinted Full"          -> " ^i(" ++ myBitmapsDir ++ "/full.xbm) "
                    "Hinted ThreeCol"      -> " ^i(" ++ myBitmapsDir ++ "/threecol.xbm) "
                    _               -> " " ++ x ++ " "
                ),
        ppTitle   = wrap ("^fg(" ++ myFocusedFGColor ++ ")") "^fg()" ,
        ppOutput  = hPutStrLn handle
}
-- }}} 
