xminid-bionic
=============

A minimal xmonad configuration with panels for Ubuntu 18.04 "Bionic Beaver".

By Kilian Evang (https://github.com/texttheater).

<img alt="Ubuntu desktop using the xmonad window manager" src="screenshot.png" width="640">

Rationale
---------

If you are like me, you want the best of both worlds: an efficient tiling
window manager that you control with your keyboard, and the friendly convenient
environment of the traditional GNOME desktop with its menus, panels, applets,
and indicators.

Recent Ubuntu releases support this requirement *almost* out of the box, thanks
to a dedicated GNOME Flashback session that uses xmonad as the window manager.
However, with an empty configuration, you won't have panels. With the default
`XMonad.Config.Gnome`, many keybindings won't work properly due to conflicts
with GNOME keybindings or bugs. So I thought I'd put together a curated minimal
xmonad config that fixes these issues but otherwise gives you a clean slate to
add your own favorite configuration options.

Setup
-----

To install everything you need, run these commands in a terminal:

    $ sudo apt install xmonad gnome-panel
    $ cd
    $ git clone https://github.com/texttheater/xminid-bionic .xmonad

From now on, when logging in, choose the "GNOME Flashback (XMonad)" session.
You can then control xmonad [with the default
keybindings](https://xmonad.org/documentation.html), only your mod key is Win
instead of Alt.

On first logging in like this, you will find that the GNOME panels are there,
but are for some reason missing a clock and the menu where you access settings,
logout, shutdown, etc. To fix this, alt-rightclick on the panel where you want
them and choose "Add to Panel...". From the window that opens, add "Clock" and
"User menu".

