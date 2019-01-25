import XMonad
import XMonad.Config.Gnome
import XMonad.Util.EZConfig
import XMonad.Util.Run

main = xmonad $ gnomeConfig {
    -- Use Win key rather than Alt. Alt is used by GNOME for many things.
    modMask = mod4Mask
} `additionalKeys` [
    -- Workaround for
    -- https://bugs.launchpad.net/ubuntu/+source/xmonad/+bug/1813049
    ((mod4Mask .|. shiftMask, xK_q), spawn "gnome-session-quit --logout")
    ]
