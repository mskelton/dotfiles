function __bm_complete_bookmarks
  bm --json | jq -r '.slug'
end

complete -c bm -f -n "__fish_use_subcommand" -a '(__bm_complete_bookmarks)'
