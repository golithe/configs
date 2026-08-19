# configs

Dotfiles and CLI tooling, managed with
[Home Manager](https://nix-community.github.io/home-manager/). Each top-level
directory is laid out relative to `$HOME`, so `nvim/.config/nvim/init.lua` lands
at `~/.config/nvim/init.lua`. The links themselves are declared in `home.nix`.

| Directory   | Contents                                                                                                    |
| ----------- | ----------------------------------------------------------------------------------------------------------- |
| `nvim`      | LazyVim config + `lazy-lock.json` plugin pins                                                                 |
| `bash`      | `.bashrc`, `.bash_aliases`, `.profile`                                                                        |
| `git`       | `.gitconfig`                                                                                                  |
| `regolith3` | Xresources for [Regolith 3](https://regolith-desktop.com/). Setup: [regolith3/README.md](regolith3/README.md) |

Links point at the working copy (`mkOutOfStoreSymlink`), not into `/nix/store`,
so files stay editable and nvim can rewrite its own lock files. The repo has to
live at `~/working/configs`.

CLI tools come from Nix + Home Manager (`home.nix`), not apt. Regolith and anything
the graphical session needs stays on apt.

Rust comes from rustup, not Nix; install it separately.

Not tracked: `~/.gitconfig.local` (per-machine identity, pulled in by `.gitconfig`).

## New machine

Install [Nix](https://nixos.org/download/), then:

```bash
git clone https://github.com/golithe/configs.git ~/working/configs
cd ~/working/configs
home-manager switch --flake .#jwi
```

Home Manager refuses to overwrite files it does not own, so move the originals
aside first. Ubuntu ships its own `~/.bashrc` and `~/.profile`.

Roll back the last switch with `home-manager switch --rollback`; list what is
available with `home-manager generations`.
