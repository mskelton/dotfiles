function tp -a dir name -d 'Create or connect to a tmux session'
  set -q name[1]; or set name $dir

  tmux new -A -c ~/dev/$dir -s $name
end
