# Dotfiles

Personal configuration files for macOS (zsh + tmux + vim).

## Repository Structure

```
.zshrc                  # Zsh shell configuration (Powerlevel10k, zap plugins, aliases, fzf)
.tmux.conf              # Tmux configuration (Nord theme, vim bindings, tpm plugins)
.tmux/scripts/          # Tmux helper scripts
  weather.sh            # Cached weather widget for tmux status bar
.vimrc                  # Vim configuration (CoC, YCM, ALE, vim-plug plugins)
```

## Source Paths

To sync this repo, pull files from these locations on the host machine:

| Repo Path | Source Path on Host |
|---|---|
| `.zshrc` | `~/.zshrc` |
| `.tmux.conf` | `~/.tmux.conf` |
| `.tmux/scripts/` | `~/.tmux/scripts/` |
| `.vimrc` | `~/.vimrc` |

## Updating This Repo

Copy the source files listed above into this repo and commit. All paths are relative to `$HOME`.
