; extends

; Awk strings
(command
  name: ((command_name) @_name
    (#eq? @_name "awk"))
  argument: ((raw_string) @awk @injection.content)
    (#set! injection.include-children)
    (#set! injection.language "awk")
    (#offset! @injection.content 0 1 0 -1))
