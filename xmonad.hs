-- Minimal xmonad configuration for Ubuntu 18.04 "Bionic Beaver"
-- =============================================================
--
-- By Kilian Evang (https://github.com/texttheater)
--
-- Rationale
-- ---------
--
-- If you are like me, you want the best of both worlds: an efficient
-- tiling window manager that you control with your keyboard, and the friendly
-- convenient environment of the traditional GNOME desktop with its menus,
-- panels, applets, and indicators.
--
-- Recent Ubuntu releases support this requirement *almost* out of the box,
-- thanks to a dedicated GNOME Flashback session that uses xmonad as the window
-- manager. However, with an empty configuration, you won't have panels, and
-- many keybindings won't work properly due to conflicts with GNOME keybindings
-- or bugs. So I thought I'd put together a curated minimal xmonad config that
-- fixes these issues but otherwise gives you a clean slate to add your own
-- favorite configuration options.
--
-- I plan to release a new version when the next LTS release of Ubuntu comes
-- out.
--
-- Setup
-- -----
--
-- 1. `sudo apt install xmonad gnome-panel`
-- 2. Make a directory `.xmonad` in your home directory and put this file
--    (`xmonad.hs`) into it.
-- 3. When logging in, choose the "GNOME Flashback (Xmonad)" session.
-- 4. On first logging in like this, you will find that the GNOME panels are
--    there, but are for some reason missing a clock and the menu where you
--    access settings, logout, shutdown, etc. To fix this, alt-rightclick on
--    the panel where you want them and choose "Add to Panel...". From the
--    window that opens, add "Clock" and "User menu".

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
