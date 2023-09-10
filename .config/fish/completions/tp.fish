function __tmux_complete_sessions
    set sessions (command tmux list-sessions -F "#{session_name}" 2> /dev/null)
    printf "%s\tSession\n" $sessions
end

complete -c tp -fk -n __fish_use_subcommand -a "(__fish_complete_directories)"
complete -c tp -fk -n __fish_use_subcommand -a '(__tmux_complete_sessions)'
