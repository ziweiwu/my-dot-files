# my-dot-files

A collection of my commonly used dotfiles for macOS.

## What's Included

| File | Description |
|------|-------------|
| `tmux.conf` | Tmux config with vim keybindings, Nord-themed status bar, weather widget, and plugin management via TPM |
| `tmux-scripts/weather.sh` | Cached weather script for the tmux status bar (refreshes every 15 min) |
| `vimrc` | Vim config with CoC, YCM, FZF, ALE, and various language plugins |
| `bashrc` | Bash config with aliases, FZF integration, and utility functions (Google search, Chrome history) |
| `.zshrc` | Zsh config with Zplugin, Powerlevel10k theme, syntax highlighting, and autosuggestions |

## Quick Setup

Clone and run the install script to symlink everything into place:

```bash
git clone https://github.com/ziweiwu/my-dot-files.git ~/my-dot-files
cd ~/my-dot-files
./install.sh
```

The install script will:
1. Back up any existing dotfiles to `~/.dotfiles-backup-<timestamp>/`
2. Symlink configs to their expected locations
3. Install TPM (Tmux Plugin Manager) if not already present
4. Create required Vim directories

After installation, open tmux and press `prefix + I` to install tmux plugins.

## Tmux

### Key Bindings

| Binding | Action |
|---------|--------|
| `h/j/k/l` | Navigate panes (vim-style, after prefix) |
| `v` | Begin selection in copy mode |
| `y` | Yank selection in copy mode |
| `prefix + Ctrl-s` | Save tmux session (tmux-resurrect) |
| `prefix + Ctrl-r` | Restore tmux session (tmux-resurrect) |

### Status Bar

Nord-themed status bar showing:
- Session name (left)
- Weather for current location (auto-detected via wttr.in)
- Battery percentage
- Date and time

### Plugins (managed by TPM)

- **tmux-sensible** - sensible defaults
- **tmux-resurrect** - persist sessions across restarts
- **tmux-continuum** - auto-save sessions every 15 min, auto-restore on start
- **tmux-sidebar** - directory tree sidebar
- **tmux-prefix-highlight** - highlight when prefix is active

## Vim

Uses vim-plug for plugin management. Key plugins: CoC (LSP), YCM, FZF, ALE (linting), NERDCommenter, and various language/theme plugins.

### Notable Leader Mappings

| Mapping | Action |
|---------|--------|
| `<leader>f` | FZF file finder |
| `<leader>s` | Save file |
| `<leader>a` | Ack search |
| `<leader>n` | Toggle line numbers |
| `<leader>k` | ClangFormat |
| `<leader>rn` | CoC rename symbol |

## Shell

Both `bashrc` and `.zshrc` include aliases for common operations. The zsh config uses Zplugin with Powerlevel10k, fast-syntax-highlighting, and autosuggestions.
