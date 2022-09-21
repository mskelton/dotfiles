function __tmux_list_sessions
  tmux list-sessions -F "#{session_id} #{session_name} #{session_path}" 2> /dev/null
end

function tp -a dir name -d 'Create or connect to a tmux session'
  # If no directory was specified, use the working directory
  set -q dir[1]; or set dir (pwd)

  # Resolve the potentially non-absolute path to an absolute path
  set resolved_dir (path resolve $dir)

  # If the directory is not found, assume it's in ~/dev
  # if not test -d $resolved_dir
  #   set resolved_dir $HOME/dev/$dir
  # end

  # If no name was provided, use the directory name
  set -q name[1]; or set name (basename $resolved_dir)

  # Loop over existing session to check if the requested session already exists
  for session in (__tmux_list_sessions)
    echo $session | read -d ' ' session_id session_name session_path

    if test "$name" = "$session_name"; or test "$resolved_dir" = "$session_path"
      # Attach if outside of Tmux, otherwise switch to it
      if test -z "$TMUX"
        tmux attach-session -t $session_id
      else
        tmux switch-client -t $session_id
      end

      return
    end
  end

  if test -z "$TMUX"
    # If we are outside a Tmux session, we can create a new session and attach
    # to it in one pass.
    tmux new-session -A -c $resolved_dir -s $name
  else
    # If we are inside a Tmux session, it's a little more work. First we create
    # a detached session and then we switch to it.
    tmux new-session -d -c $resolved_dir -s $name
    tmux switch-client -t $name
  end
end
