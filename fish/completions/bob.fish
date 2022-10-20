function __bob_list_scripts
  ls $HOME/dev/bob/bin/* | xargs basename
end

complete -c bob -f -n "__fish_use_subcommand" -a '(__bob_list_scripts)'
