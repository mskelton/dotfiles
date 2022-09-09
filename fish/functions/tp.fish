function tp -a dir name -d 'Create or connect to a tmux session'
  set -q dir[1]; or set dir (basename (pwd))

  if test -n "$TMUX"
    tmux switch -t $dir
  else 
    set -q name[1]; or set name $dir
    tmux new -A -c ~/dev/$dir -s $name
  end
end
