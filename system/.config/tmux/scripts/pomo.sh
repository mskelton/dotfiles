#!/usr/bin/env bash

status=$(pomo --notify)

# Prints the pomodoro status with a more obvious background when in tmux. If
# there is no active session, this will not print anything.
if [[ -n "$status" ]]; then
	echo "#[fg=#737aa2]$status"
fi
