status is-login; and begin
    # Login shell initialisation
end

status is-interactive; and begin
    set fish_greeting # Disable greeting
    echo
    pfetch

    # Abbreviations
    abbr --add -- cd z
    abbr --add -- ga 'git add'
    abbr --add -- ga. 'git add .'
    abbr --add --set-cursor -- gc 'git commit -m  "%"'
    abbr --add -- gco 'git checkout'
    abbr --add -- gd 'git diff'
    abbr --add -- gd. 'git diff .'
    abbr --add -- gi 'git init'
    abbr --add -- gl 'git log -10 --oneline'
    abbr --add -- gp 'git push'
    abbr --add -- gpl 'git pull'
    abbr --add -- gr 'git reset'
    abbr --add -- gs 'git status'
    abbr --add -- mk make
    abbr --add -- nhh 'nh home switch'
    abbr --add -- nho 'nh os switch'
    abbr --add -- vi nvim

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
