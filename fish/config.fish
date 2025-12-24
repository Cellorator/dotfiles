status is-login; and begin
    # Login shell initialisation
end

status is-interactive; and begin
    set fish_greeting # Disable greeting
    echo
    pfetch

    # Abbreviations
    abbr -a cd z

    abbr -a ga 'git add'
    abbr -a ga. 'git add .'
    abbr -a --set-cursor gc 'git commit -m  "%"'
    abbr -a gco 'git checkout'
    abbr -a gd 'git diff'
    abbr -a gd. 'git diff .'
    abbr -a gi 'git init'
    abbr -a gl 'git log -10 --oneline'
    abbr -a gp 'git push'
    abbr -a gpl 'git pull'
    abbr -a gr 'git reset'
    abbr -a gs 'git status'

    abbr -a mk make

    abbr -a vi nvim

    abbr -a cl clear

    abbr -a py python

    abbr -a emr 'systemctl restart --user emacs'

    # Aliases
    alias bat 'bat -n'
    alias cat 'bat -n'
    alias fzf 'fzf --preview "bat -n --color=always {}"'
    alias la 'eza -la --group-directories-first --icons'
    alias ll 'eza -l'
    alias lla 'eza -la'
    alias ls 'eza -1 --group-directories-first --icons'
    alias lt 'eza --tree'
    alias tree 'eza -T --group-directories-first --icons'
    alias vif 'fzf --preview "bat -n --color=always {}" | xargs nvim'

    zoxide init fish | source
    starship init fish | source
end
