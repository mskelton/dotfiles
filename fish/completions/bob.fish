function __bob_list_scripts
  ls $HOME/dev/bob/*.fish | xargs basename | sed 's/.fish//'
end

complete -c bob -f -n "__fish_use_subcommand" -a '(__bob_list_scripts)'
