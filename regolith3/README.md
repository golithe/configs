# Regolith 3 on Pop!_OS

Install: https://regolith-desktop.com/docs/using-regolith/install/

Pop 24.04 ships cosmic-greeter, which cannot launch X11 sessions,
so Regolith won't appear at login until the display manager is swapped:

    sudo apt install gdm3
    sudo dpkg-reconfigure gdm3   # select gdm3

Verify both agree, then reboot:

    cat /etc/X11/default-display-manager        # /usr/sbin/gdm3
    ls -l /etc/systemd/system/display-manager.service

Xresources here is symlinked to ~/.config/regolith3/Xresources.
Apply changes with: `regolith-look refresh`

## Session fixes

Pop 24.04 defaults to COSMIC, so the GNOME plumbing Regolith rides on is
installed but untested. `cosmic-settings` writes to `~/.config/cosmic/` and
affects none of this.

| File | Fixes |
| ---- | ----- |
| `i3/config.d/90_xsettings` | Regolith's session target drops `BindsTo=gnome-session-x11.target`, so `gsd-xsettings` dies on its `Requisite=` and GTK apps fall back to Yaru light |
| `xdg-desktop-portal/regolith-portals.conf` | the regolith portal backend answers `org.freedesktop.appearance` `color-scheme` with "key not found", leaving libadwaita apps light |

Keep `input-sources` to a single layout. i3 resolves unqualified `bindsym`
against layout group 1 only, so a second group silently moves every binding on a
key that shifts between layouts: with `[ch, us]`, `Super+Shift+?` ran
`gaps inner current minus 12`.

Display scale lives in `home.nix` (`text-scaling-factor`), not here:
`gsd-xsettings` recomputes `Xft.dpi` as `96 * factor` and overwrites Xresources.

Verify:

    pgrep -x gsd-xsettings
    xrdb -query | grep Xft.dpi                 # 120
    gdbus call --session --dest org.freedesktop.portal.Desktop \
      --object-path /org/freedesktop/portal/desktop \
      --method org.freedesktop.portal.Settings.ReadOne \
      org.freedesktop.appearance color-scheme  # uint32 1
