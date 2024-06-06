# Setup

```
git init --bare $HOME/.my-config
alias config='/usr/bin/git --git-dir=$HOME/.my-config/ --work-tree=$HOME'
config remote add origin git@github.com:rachelleburgos/dotfiles.git
```

# Replication

```
git clone --separate-git-dir=$HOME/.cfg https://github.com/rachelleburgos/dotfiles.git dotfiles-tmp
rsync --recursive --verbose --exclude '.git' dotfiles-tmp/ $HOME/
rm --recursive dotfiles-tmp
```

# Configuration

```
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/..my-config/ --work-tree=$HOME'" >> $HOME/.zshrc
echo "alias config='/usr/bin/git --git-dir=$HOME/..my-config/ --work-tree=$HOME'" >> $HOME/.bashrc
```

# Usage

```
config status
config add .gitconfig
config commit -m 'Add gitconfig'
config push
```
