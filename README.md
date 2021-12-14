# dotfiles

## How to:

1. Clone this repo in $HOME
2. Create a symlink from a file inside this repo to the users $HOME directory using the following command:

```bash
ln -nfs $HOME/dotfiles/.gitconfig $HOME/.gitconfig
```

to automatically symlink all files to the user's home run this script:

```bash
for file in .{aliases,bash_profile,Brewfile,fzf.zsh,gitconfig,vimrc,zshrc}; do
	ln -nfs $HOME/dotfiles/$file $HOME/$file
done;
```

## Additional configuration:

### Brewfile:

Run the following command to install all packages:

```bash
brew bundle
```
