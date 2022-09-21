function source-fish -d 'Re-source all fish functions and configuration files'
  for file in $HOME/.config/fish/**/*.fish
    source $file
  end
end
