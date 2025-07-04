function __tmux_complete_apps
    ls -1 -d $HOME/dev/* | xargs -I {} basename "{}"
end

complete -c ts -fk -n __fish_use_subcommand -a '(__tmux_complete_apps)'
