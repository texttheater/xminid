import Control.Monad (join, when)
import Data.Maybe (maybeToList)
import XMonad
import XMonad.Config.Gnome (gnomeConfig)
import XMonad.Hooks.EwmhDesktops (ewmhFullscreen)
import XMonad.Util.EZConfig (additionalKeys)

main = xmonad $ ewmhFullscreen gnomeConfig {
    -- Use Win key rather than Alt. Alt is used by GNOME for many things.
    modMask = mod4Mask,
    startupHook = composeAll [
        startupHook gnomeConfig,
        -- fix fullscreen for Firefox
        -- https://github.com/xmonad/xmonad-contrib/issues/288
        fullscreenStartupHook
    ]
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
