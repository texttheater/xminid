import Control.Monad
import Data.Maybe
import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig
import XMonad.Util.Run

main = xmonad $ gnomeConfig {
    -- Use Win key rather than Alt. Alt is used by GNOME for many things.
    modMask = mod4Mask,
    manageHook = composeAll [
        manageHook gnomeConfig,
        -- open applications on specific workspaces
        className =? "Mail" --> doShift "1",
        className =? "Thunderbird" --> doShift "1",
        className =? "Navigator" --> doShift "2",
        className =? "Firefox" --> doShift "2",
        className =? "libreoffice" --> doShift "5",
        className =? "libreoffice-startcenter" --> doShift "5",
        className =? "libreoffice-writer" --> doShift "5",
        className =? "evince" --> doShift "6",
        className =? "Evince" --> doShift "6",
        className =? "mendeleydesktop.x86_64" --> doShift "8",
        className =? "Mendeley Desktop" --> doShift "8",
        className =? "update-manager" --> doShift "9",
        className =? "Update-manager" --> doShift "9",
        className =? "microsoft teams - preview" --> doShift "9",
        className =? "Microsoft Teams - Preview" --> doShift "9",
        className =? "skype" --> doShift "9",
        className =? "Skype" --> doShift "9",
        className =? "slack" --> doShift "9",
        className =? "Slack" --> doShift "9",
        className =? "zoom" --> doShift "9"
    ],
    startupHook = composeAll [
        startupHook gnomeConfig,
        -- fix fullscreen for Firefox
        -- https://github.com/xmonad/xmonad-contrib/issues/288
        fullscreenStartupHook,
        -- start update-manager on startup because we don't have the normal
        -- Ubuntu session to do that for us
        spawn "update-manager"
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
} `additionalKeys` [
    -- Workaround for
    -- https://bugs.launchpad.net/ubuntu/+source/xmonad/+bug/1813049
    ((mod4Mask .|. shiftMask, xK_q), spawn "gnome-session-quit --logout")
    ]

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
