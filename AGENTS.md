# Agent Instructions for my-dot-files

This repository contains personal dotfiles for macOS. Follow these guidelines when making changes.

## Repository Structure

```
my-dot-files/
├── tmux.conf              # → ~/.tmux.conf
├── tmux-scripts/
│   └── weather.sh         # → ~/.tmux/scripts/weather.sh
├── vimrc                  # → ~/.vim/vimrc
├── bashrc                 # → ~/.bashrc
├── .zshrc                 # → ~/.zshrc
├── .zshrc.local.example   # Template for ~/.zshrc.local (NOT symlinked)
├── install.sh             # Setup script for new machines
├── README.md              # Human-readable documentation
└── AGENTS.md              # This file
```

**Important:** `~/.zshrc.local` is machine-specific and must NEVER be committed to this repo. It contains sensitive or environment-specific settings (Java paths, Conda, work aliases, API tokens). The `.zshrc.local.example` file is the public template.

## Editing Guidelines

- **Do not remove existing key bindings or aliases** without explicit user request. These are muscle-memory mappings.
- **Preserve comments** — many settings have inline explanations that serve as documentation.
- **tmux.conf**: The `run -b '~/.tmux/plugins/tpm/tpm'` line must stay at the very bottom of the file.
- **tmux.conf**: The status bar uses Nerd Font icons (e.g. ``, `󰁝`, `󰁹`). Ensure your editor handles Unicode correctly.
- **vimrc**: Plugin declarations (`Plug '...'`) must stay inside the `plug#begin` / `plug#end` block.
- **Weather script**: Uses macOS `stat -f %m` syntax. If adding Linux support, handle both `stat` flavors.
- **install.sh**: Always back up existing files before overwriting. Never use `rm` or force-overwrite without backup.

## Adding New Configs

1. Add the config file to the repo root (or a subdirectory for scripts/assets).
2. Update `install.sh` to symlink it to the correct location.
3. Update `README.md` with a description of the new file.
4. Document the target path in the structure table above.

## Testing Changes

- After editing `tmux.conf`: run `tmux source-file ~/.tmux.conf` to reload.
- After editing `vimrc`: restart Vim or run `:source ~/.vim/vimrc`.
- After editing shell configs: run `source ~/.bashrc` or `source ~/.zshrc`.
- After editing `install.sh`: test on a clean directory with `HOME=/tmp/test-home ./install.sh`.
