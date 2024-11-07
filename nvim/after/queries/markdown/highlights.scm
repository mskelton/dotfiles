; extends

; MDX
((paragraph) @_javascript @nospell
  (#match? @_javascript "^(import|export).+$"))
((paragraph) @_javascript @nospell
  (#match? @_javascript "^[<][A-z]+.*$"))
