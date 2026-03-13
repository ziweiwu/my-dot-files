# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ===== ZAP PLUGIN MANAGER =====
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# ===== THEME =====
plug "romkatv/powerlevel10k"

# ===== PLUGINS =====
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/supercharge"
plug "zap-zsh/vim"

# ===== SHELL OPTIONS =====
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt EXTENDED_GLOB
setopt GLOB_DOTS
setopt NO_CASE_GLOB
setopt CORRECT
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt PROMPT_SUBST

# Remove 4% indicator
PROMPT_EOL_MARK=''

# ===== HISTORY =====
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

# ===== COMPLETION =====
autoload -Uz compinit
compinit -d ~/.zsh/zcompdump

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# ===== ENVIRONMENT =====
export LANG=en_US.UTF-8
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LESS='-R -F -X -i -M'

# ===== PATH =====
typeset -U path
path=(
    $HOME/.local/bin
    $HOME/bin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    /opt/homebrew/opt/openjdk@21/bin
    /usr/local/bin
    $path
)
export PATH

# ===== JAVA =====
export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"

# ===== NVM (LAZY LOADED) =====
export NVM_DIR="$HOME/.nvm"

nvm() {
    unset -f nvm node npm npx
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    nvm "$@"
}

node() {
    unset -f nvm node npm npx
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    node "$@"
}

npm() {
    unset -f nvm node npm npx
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    npm "$@"
}

npx() {
    unset -f nvm node npm npx
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    npx "$@"
}

# ===== BASIC ALIASES =====
alias reload="exec zsh"
alias zshconfig="$EDITOR ~/.zshrc"

# Tmux sessions (run directly if already in tmux, otherwise always create new session)
c() {
    if [ -n "$TMUX" ]; then
        claude "$@"
    else
        tmux new-session -s "claude-$(date +%s)" claude
    fi
}
k() {
    if [ -n "$TMUX" ]; then
        kiro-cli chat "$@"
    else
        tmux new-session -s "kiro-$(date +%s)" "kiro-cli chat"
    fi
}
g() {
    if [ -n "$TMUX" ]; then
        gemini "$@"
    else
        tmux new-session -s "gemini-$(date +%s)" gemini
    fi
}
alias n="nvim"
alias t="tmux"

# Modern tools
if command -v eza &> /dev/null; then
    alias ls='eza --icons'
    alias ll='eza -l --icons --git'
    alias la='eza -la --icons --git'
    alias lt='eza --tree --icons --level=2'
else
    alias ll='ls -lh'
    alias la='ls -lAh'
fi

command -v bat &> /dev/null && alias cat='bat --style=auto'
command -v fd &> /dev/null && alias find='fd'
command -v rg &> /dev/null && alias grep='rg'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate'

# ===== NPM ALIASES =====
alias ni="npm install"
alias nr="npm run"
alias ns="npm start"
alias nt="npm test"
alias nb="npm run build"
alias nd="npm run dev"
alias nci="npm ci"

# Yarn
alias yi="yarn install"
alias yr="yarn run"
alias ys="yarn start"
alias yt="yarn test"
alias yb="yarn build"
alias yd="yarn dev"

# pnpm
alias pi="pnpm install"
alias pr="pnpm run"
alias ps="pnpm start"
alias pt="pnpm test"
alias pb="pnpm build"
alias pd="pnpm dev"

# Smart detection
alias install-deps='[[ -f yarn.lock ]] && yarn || [[ -f pnpm-lock.yaml ]] && pnpm install || npm install'
alias run-dev='[[ -f yarn.lock ]] && yarn dev || [[ -f pnpm-lock.yaml ]] && pnpm dev || npm run dev'
alias run-build='[[ -f yarn.lock ]] && yarn build || [[ -f pnpm-lock.yaml ]] && pnpm build || npm run build'
alias run-test='[[ -f yarn.lock ]] && yarn test || [[ -f pnpm-lock.yaml ]] && pnpm test || npm test'

# ===== FZF =====
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --inline-info'

if command -v fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

if command -v bat &> /dev/null; then
    export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always {}'"
fi

# FZF functions
ff() {
    local file=$(fzf --preview 'bat --style=numbers --color=always {} 2>/dev/null || cat {}')
    [ -n "$file" ] && $EDITOR "$file"
}

fcd() {
    local dir=$(fd --type d 2>/dev/null | fzf --preview 'ls -la {}')
    [ -n "$dir" ] && cd "$dir"
}

fgb() {
    local branch=$(git branch --all | grep -v HEAD | sed 's/^[* ]*//' | fzf)
    [ -n "$branch" ] && git checkout "$(echo "$branch" | sed 's#remotes/[^/]*/##')"
}

fgl() {
    git log --oneline --color=always | fzf --ansi --preview 'git show --color=always {1}'
}

frg() {
    [ $# -eq 0 ] && echo "Usage: frg <search_term>" && return 1
    local file=$(rg --files-with-matches "$1" | fzf --preview "rg --color=always --context 10 '$1' {}")
    [ -n "$file" ] && $EDITOR "$file"
}

fkill() {
    local pid=$(ps aux | sed 1d | fzf -m | awk '{print $2}')
    [ -n "$pid" ] && echo "$pid" | xargs kill -"${1:-9}"
}

# ===== CONDA =====
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup

# ===== ZOXIDE =====
eval "$(zoxide init zsh)"

# ===== EXTERNAL INTEGRATIONS =====
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
[ -f "${HOME}/.iterm2_shell_integration.zsh" ] && source "${HOME}/.iterm2_shell_integration.zsh"

# ===== POWERLEVEL10K =====
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
