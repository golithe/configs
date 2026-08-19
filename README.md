# configs

Dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/). Each
top-level directory is a package laid out relative to `$HOME`, so
`nvim/.config/nvim/init.lua` lands at `~/.config/nvim/init.lua`.

| Package     | Contents                                                                                                    |
| ----------- | ----------------------------------------------------------------------------------------------------------- |
| `nvim`      | LazyVim config + `lazy-lock.json` plugin pins                                                                 |
| `bash`      | `.bashrc`, `.bash_aliases`, `.profile`                                                                        |
| `regolith3` | Xresources for [Regolith 3](https://regolith-desktop.com/). Setup: [regolith3/README.md](regolith3/README.md) |

CLI tools come from Nix + Home Manager (`home.nix`), not apt. Regolith and anything
the graphical session needs stays on apt.

Not tracked: `.gitconfig` (identity differs per machine).

## New machine

Install [Nix](https://nixos.org/download/), then:

```bash
git clone https://github.com/golithe/configs.git ~/working/configs
cd ~/working/configs
home-manager switch --flake .#jwi
stow -t ~ */
```

Home Manager comes first because it installs stow.

`-t ~` is required: stow otherwise targets the parent dir, `~/working`. Stow won't
clobber existing real files, so move the originals aside first. Ubuntu ships its
own `~/.bashrc` and `~/.profile`.

Undo with `stow -D -t ~ <package>`.
