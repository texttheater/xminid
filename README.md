xminid
======

A minimal xmonad configuration with panels for Ubuntu 20.04 “Focal Fossa”,
Ubuntu 22.04 “Jammy Jellyfish”, and Ubuntu 24.03 “Noble Numbat”.

By [Kilian Evang](https://github.com/texttheater).

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
`XMonad.Config.Gnome`, there are still some unacceptable problems:

* Many keybindings won't work properly due to conflicts with GNOME keybindings
  or bugs.
* Applications going fullscreen (like media players or browsers) is not
  supported.

So I thought I'd put together a curated minimal xmonad config that fixes these
issues but otherwise gives you a clean slate to add your own favorite
configuration options.

Setup for Ubuntu 20.04 and 22.04
--------------------------------

Due to a [bug](https://bugs.launchpad.net/ubuntu/+source/xmonad/+bug/1919089),
the *GNOME Flashback (Xmonad)* session does not work. I recommend you use
[Gekkio’s Gnome + XMonad](https://github.com/Gekkio/gnome-session-xmonad)
session instead. The complete setup procedure then is:

    $ sudo apt install xmonad gnome-panel
    $ sudo add-apt-repository ppa:gekkio/xmonad
    $ sudo apt update
    $ sudo apt install gnome-session-xmonad
    $ cd
    $ git clone https://github.com/texttheater/xminid .xmonad

In addition, to work around a [bug](https://github.com/Gekkio/gnome-session-xmonad/issues/14)
where panels are not visible, run this:

    $ gsettings set org.gnome.gnome-flashback root-background true
    $ gsettings set org.gnome.gnome-flashback desktop false

From now on, when logging in, choose the *Gnome+XMonad* session.

Setup for Ubuntu 24.04
----------------------

Gekkio’s Gnome + Xmonad session is no longer updated so there is no package for
Ubuntu 24.04. Instead, I’ve taken to using the ‘Gnome Flashback (Metacity)’
session and using the autostart feature to replace Metacity with Xmonad after
logging in, courtesy of [symmetry81 on
reddit](https://www.reddit.com/r/xmonad/comments/nyfq5b/xmonad_and_gnome_in_ubuntu_2104_success/),
adapted to do nothing if Metacity is not running so that you can still use the
‘Ubuntu’ session using Gnome Shell as well. The complete setup procedure then
is:

    $ sudo apt install xmonad gnome-flashback gnome-panel
    $ cd
    $ git clone https://github.com/texttheater/xminid .xmonad
    $ mkdir -p .config/autostart
    $ cp .xmonad/xmonad.desktop .config/autostart

Usage
-----

After logging in, you can control xmonad [with the default
keybindings](https://xmonad.org/documentation.html), only your mod key is Win
instead of Alt.

The key binding for switching to the next layout (Mod+Space) conflicts with
Ubuntu's default for switching to the next input source. Consider disabling or
changing the latter via Ubuntu's keyboard shortcut settings.

You may find that the GNOME panels are missing some standard items, or they are
in weird places, or duplicated. To fix this, alt-rightclick on the relevant
places of the panels and choose *Add to Panel...*, *Move*, or *Remove from
Panel* to add, move, or remove items as desired.

To customize your xmonad setup, edit `~/.xmonad/xmonad.hs` as usual. For more
information, check the [xmonad
documentation](https://xmonad.org/documentation.html).

Cosmetics
---------

For making the colors and panel icons look nice together, I recommend:

    sudo apt install light-themes gnome-tweaks

Then open `gnome-tweaks`, go to Appearance. Use the following themes:

| Type                | Recommended theme |
| ------------------- | ----------------- |
| Cursor              | Yaru              |
| Icons               | Ubuntu-mono-dark  |
| Legacy Applications | Ambiance          |
