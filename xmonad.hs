import XMonad
import XMonad.Config.Gnome
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
        -- start update-manager on startup because we don't have the normal
        -- Ubuntu session to do that for us
        spawn "update-manager"
    ]
} `additionalKeys` [
    -- Workaround for
    -- https://bugs.launchpad.net/ubuntu/+source/xmonad/+bug/1813049
    ((mod4Mask .|. shiftMask, xK_q), spawn "gnome-session-quit --logout")
    ]
