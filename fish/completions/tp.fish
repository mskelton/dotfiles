function __fish_tmux_sessions
  if test -n "$TMUX"
    set sessions (command tmux list-sessions -F "#{session_name}")
    printf "%s\tSession\n" $sessions
  end
end

complete -c tp -fk -n "__fish_use_subcommand" -a "(__fish_complete_directories)"
complete -c tp -fk -n "__fish_use_subcommand" -a '(__fish_tmux_sessions)'
