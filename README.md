# configs

Dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/). Each
top-level directory is a package laid out relative to `$HOME`, so
`nvim/.config/nvim/init.lua` lands at `~/.config/nvim/init.lua`.

| Package | Contents |
| ------- | -------- |
| `nvim`  | LazyVim config + `lazy-lock.json` plugin pins |
| `bash`  | `.bashrc`, `.bash_aliases` |

Not tracked: `.gitconfig` — identity differs per machine.

## New machine

```bash
sudo apt install stow
git clone https://github.com/golithe/configs.git ~/working/configs
cd ~/working/configs
stow -t ~ */
```

`-t ~` is required: stow otherwise targets the parent dir, `~/working`. Stow won't
clobber existing real files, so move the originals aside first. Undo with
`stow -D -t ~ <package>`.
