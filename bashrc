export PS1="\h \w\$(parse_git_branch) > "
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

#lower recognition threshold for key sequence
export KEYTIMEOUT=0

# fzf to respect gitignore
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
alias ff='cd "$(fd | fzf)"'

# Reload bashrc 
alias reload="source ~/.bashrc"

# configs
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vim/vimrc"
alias bashrc="vim ~/.bashrc"
alias emacs_config="emacs -nw ~/.spacemacs"

# shell commands
alias rm="rm -i"
alias l="ls"
alias ll="ls -alF"
alias c="clear"

# toolings 
# vim
alias v=vim
alias vi=vim

# Git
alias gcm="git commit -m"
alias gaa="git add ."

# tree
alias tree="tree -I 'node_modules|bower_components'"

# view cpu usage
alias cpu="top -F -R -o cpu"

# c - browse chrome history
chis() {
  local cols sep
  export cols=$(( COLUMNS / 3 ))
  export sep='{::}'

  cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select title, url from urls order by last_visit_time desc" |
  ruby -ne '
    cols = ENV["cols"].to_i
    title, url = $_.split(ENV["sep"])
    len = 0
    puts "\x1b[36m" + title.each_char.take_while { |e|
      if len < cols
        len += e =~ /\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul}/ ? 2 : 1
      end
    }.join + " " * (2 + cols - len) + "\x1b[m" + url' |
  fzf --ansi --multi --no-hscroll --tiebreak=index |
  sed 's#.*\(https*://\)#\1#' | xargs open
}

google() {
    search=""
    echo "Googling: $@"
    for term in $@; do
        search="$search%20$term"
    done
    open "http://www.google.com/search?q=$search"
    #xdg-open "http://www.google.com/search?q=$search"
}
