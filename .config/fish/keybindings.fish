function fish_hybrid_key_bindings
    fzf --fish | source
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase

    # Use Ctrl+x since it's something we can map cmd+k to for clearing the screen
    bind -M insert \cx 'echo -n (clear | string replace \e\[3J ""); commandline -f repaint'

    # Open tmux-sessionizer with Ctrl+f
    bind -M insert \cf "tmux-sessionizer; commandline -f repaint"

    # Use _ to go to the beginning of the line as I use this a lot in Vim
    bind -s --preset _ beginning-of-line
    bind -s --preset -M visual _ beginning-of-line

    # Switch between modes with escape. A little out of the ordinary, but I find
    # myself doing it a lot. Also updates escape in insert mode to not move
    # backwards one character.
    bind -s --preset -M insert \e "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f repaint-mode; end"
    bind -s --preset \e "set fish_bind_mode insert; commandline -f repaint-mode"
end

# Use my custom keybindings
set -g fish_key_bindings fish_hybrid_key_bindings
