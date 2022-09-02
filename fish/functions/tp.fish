function tp --description 'alias tp=tmux new -s $1 -c ~/dev/$1'
  tmux new -A -s $argv -c ~/dev/$argv
end
