import Control.Monad (join, when)
import Data.Maybe (maybeToList)
import XMonad
import XMonad.Actions.OnScreen (Focus(FocusTag), onScreen)
import XMonad.Config.Gnome (gnomeConfig)
import XMonad.Hooks.EwmhDesktops (fullscreenEventHook)
import XMonad.Layout.IndependentScreens (countScreens)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.StackSet (view)
import XMonad.Util.EZConfig (additionalKeys)

viewOnFirstScreen :: WorkspaceId -> X ()
viewOnFirstScreen i = do
   windows (onScreen (view i) (FocusTag i) 0)

viewOnLastScreen :: WorkspaceId -> X ()
viewOnLastScreen i = do
    numScreens <- countScreens
    let sid = numScreens - 1
    windows (onScreen (view i) (FocusTag i) sid)

main = xmonad $ gnomeConfig {
    -- Use Win key rather than Alt. Alt is used by GNOME for many things.
    modMask = mod4Mask,
    manageHook = composeAll [
        manageHook gnomeConfig,
        -- open applications on specific workspaces
        className =? "skype" --> doShift "1",
        className =? "Skype" --> doShift "1",
        className =? "signal" --> doShift "1",
        className =? "Signal" --> doShift "1",
        className =? "zoom" --> doShift "1",
        className =? "Mail" --> doShift "2",
        className =? "Thunderbird" --> doShift "2",
        className =? "code" --> doShift "4",
        className =? "Code" --> doShift "4",
        className =? "libreoffice" --> doShift "5",
        className =? "libreoffice-startcenter" --> doShift "5",
        className =? "libreoffice-writer" --> doShift "5",
        className =? "evince" --> doShift "6",
        className =? "Evince" --> doShift "6",
        className =? "okular" --> doShift "6",
        className =? "firefox" --> doShift "7",
        className =? "Mendeley Desktop" --> doShift "8",
        className =? "Mendeley Reference Manager" --> doShift "8",
        className =? "Zotero" --> doShift "8",
        className =? "update-manager" --> doShift "9",
        className =? "Update-manager" --> doShift "9"
    ],
    startupHook = composeAll [
        startupHook gnomeConfig,
        -- fix fullscreen for Firefox
        -- https://github.com/xmonad/xmonad-contrib/issues/288
        fullscreenStartupHook,
        -- start update-manager on startup because we don't have the normal
        -- Ubuntu session to do that for us
        spawn "update-manager",
        -- kill Wine/P.O.D.
        spawn "killall -9 wineserver64 winedevice.exe PODX#fx.exe"
    ],
    handleEventHook = composeAll [
        handleEventHook gnomeConfig,
        -- fix fullscreen
        fullscreenEventHook
    ],
    layoutHook = 
        -- no borders around the only window on screen
        smartBorders $
        layoutHook gnomeConfig
} `additionalKeys` ([
    ((mod4Mask, xK_1), (viewOnFirstScreen "1")),
    ((mod4Mask, xK_2), (viewOnFirstScreen "2")),
    ((mod4Mask, xK_3), (viewOnFirstScreen "3")),
    ((mod4Mask, xK_4), (viewOnFirstScreen "4")),
    ((mod4Mask, xK_5), (viewOnFirstScreen "5")),
    ((mod4Mask, xK_6), (viewOnLastScreen "6")),
    ((mod4Mask, xK_7), (viewOnLastScreen "7")),
    ((mod4Mask, xK_8), (viewOnLastScreen "8")),
    ((mod4Mask, xK_9), (viewOnLastScreen "9"))
    ])

fullscreenStartupHook :: X ()
fullscreenStartupHook = withDisplay $ \dpy -> do
    r <- asks theRoot
    a <- getAtom "_NET_SUPPORTED"
    c <- getAtom "ATOM"
    f <- getAtom "_NET_WM_STATE_FULLSCREEN"
    io $ do
        sup <- (join . maybeToList) <$> getWindowProperty32 dpy a r
        when (fromIntegral f `notElem` sup) $
            changeProperty32 dpy r a c propModeAppend [fromIntegral f]
