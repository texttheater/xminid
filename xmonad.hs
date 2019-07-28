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
        className =? "update-manager" --> doShift "9",
        className =? "Update-manager" --> doShift "9"
    ],
    startupHook = composeAll [
        startupHook gnomeConfig,
        -- fix fullscreen for Firefox
        -- https://gist.github.com/sboehler/5f48017a6b53805485180a9a6d81196b
        setFullscreenSupported,
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

setFullscreenSupported :: X ()
setFullscreenSupported = withDisplay $ \dpy -> do
    r <- asks theRoot
    a <- getAtom "_NET_SUPPORTED"
    c <- getAtom "ATOM"
    supp <- mapM getAtom [
        "_NET_WM_STATE_HIDDEN",
        "_NET_WM_STATE_FULLSCREEN", -- XXX Copy-pasted to add this line
        "_NET_NUMBER_OF_DESKTOPS",
        "_NET_CLIENT_LIST",
        "_NET_CLIENT_LIST_STACKING",
        "_NET_CURRENT_DESKTOP",
        "_NET_DESKTOP_NAMES",
        "_NET_ACTIVE_WINDOW",
        "_NET_WM_DESKTOP",
        "_NET_WM_STRUT"
        ]
    io $ changeProperty32 dpy r a c propModeReplace (fmap fromIntegral supp)
    setWMName "xmonad"
