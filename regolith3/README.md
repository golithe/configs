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
