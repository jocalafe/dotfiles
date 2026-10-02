# dotfiles

## Setup on macOS

1. Install [Homebrew](https://brew.sh/), [Oh My Zsh](https://ohmyz.sh/#install), and [NVM](https://github.com/nvm-sh/nvm#installing-and-updating). The NVM configuration expects its data directory at `~/.nvm`.
2. Clone this repository into `$HOME/dotfiles`.
3. Link the dotfiles. Back up any existing regular files at the target paths first; this replaces existing symlinks.

```bash
cd "$HOME/dotfiles"
for file in .aliases .Brewfile .fzf.zsh .gitconfig .vimrc .zshrc; do
  target="$HOME/$file"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Back up $target before linking" >&2
    exit 1
  fi
  ln -sfn "$HOME/dotfiles/$file" "$target"
done

mkdir -p "$HOME/.config/ghostty"
target="$HOME/.config/ghostty/config.ghostty"
if [ -e "$target" ] && [ ! -L "$target" ]; then
  echo "Back up $target before linking" >&2
  exit 1
fi
ln -sfn "$HOME/dotfiles/.config/ghostty/config.ghostty" "$target"

target="$HOME/.config/starship.toml"
if [ -e "$target" ] && [ ! -L "$target" ]; then
  echo "Back up $target before linking" >&2
  exit 1
fi
ln -sfn "$HOME/dotfiles/.config/starship.toml" "$target"
```

4. Install the Homebrew packages and Ghostty from the linked global Brewfile:

```bash
brew bundle --global
```

The NVM hook is skipped until NVM is installed. Oh My Zsh, Starship, zoxide, and fzf integrations are also guarded so a shell can start while optional tools are missing. Install the Vim runtime under `~/.vim_runtime` if you want the extra Vim configuration; plain Vim starts without it.

## Included setup

- `.zshrc` and `.aliases` for zsh
- `.config/ghostty/config.ghostty` for Ghostty shortcuts
- `.gitconfig` for editor, pull, and push defaults
- `.Brewfile` for Homebrew packages and Ghostty
- `.vimrc` for optional Vim runtime configuration
