function zoom --description 'Increase or decrease the font size of the active Kitty window'
  set size $argv[1]
  test -z "$size"; and set size 0

  kitty @ set-font-size $size
end
