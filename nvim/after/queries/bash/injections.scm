; extends

; awk, sed
(command
  name: ((command_name) @injection.language
    (#any-of? @injection.language "awk" "sed"))
  argument: ([(raw_string) (string)] @injection.content)
    (#set! injection.include-children)
    (#offset! @injection.content 0 1 0 -1))
