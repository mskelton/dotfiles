#!/usr/bin/env bash

status=$(pomo)

# Prints the pomodoro status with a more obvious background when in tmux. If
# there is no active session, this will not print anything.
if [[ ! -z "$status" ]]; then
	echo "#[fg=#7aa2f7]#[fg=#1D202F,bg=#7aa2f7] $status "
fi
