function bob -d "Your automation friend"
  # Ensure a script argument was provided
  set script $argv[1]
  if test -z $script
    echo "Error: no script provided"
    return 1
  end

  # Ensure the script exists
  set resolved_script $HOME/dev/bob/$script.fish
  if not test -f $resolved_script
    echo "Error: script not found"
    return 1
  end

  # Run the requested script
  $resolved_script
end
