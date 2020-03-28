### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin installer's chunk

# zplugins
zplugin ice wait blockf atpull'zplugin creinstall -q .'
zplugin light zsh-users/zsh-completions

zplugin ice wait atinit"zpcompinit; zpcdreplay"
zplugin light zdharma/fast-syntax-highlighting

zplugin ice wait atload"_zsh_autosuggest_start"
zplugin light zsh-users/zsh-autosuggestions

zplugin light "chrissicool/zsh-256color"
zplugin load zdharma/history-search-multi-word
zplugin ice depth=1; zplugin light romkatv/powerlevel10k

zplugin ice as"program" pick"bin/git-dsf"
zplugin light zdharma/zsh-diff-so-fancy

#alias
alias git diff="git diff --color | diff-so-fancy"
alias zshconfig="mvim ~/.zshrc"
alias reload="source ~/.zshrc"
alias ycmInstall="python ~/.vim/plugged/YouCompleteMe/install.py"
alias workplaceSync="brazil ws sync"
alias e="emacs --no-wait"
alias v=vim
alias vi=vi
