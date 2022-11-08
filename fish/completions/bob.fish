function __bob_list_scripts
  find $HOME/dev/bob/bin -type f -print | xargs -n 1 basename
end

complete -c bob -f -n "__fish_use_subcommand" -a '(__bob_list_scripts)'
