# dotfiles

One repo for all configs. Live paths are symlinks into here:

- `nvim/` → `~/.config/nvim`
- `ghostty/` → `~/.config/ghostty`
- `zsh/.zshrc` → `~/.zshrc`

## Fresh Mac setup

```sh
git clone https://github.com/SalzDevs/dotfiles.git ~/dotfiles
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/ghostty ~/.config/ghostty
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
```
