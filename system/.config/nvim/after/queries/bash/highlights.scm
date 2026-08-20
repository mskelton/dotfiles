; extends

[
 (string)
 (raw_string)
 (ansi_c_string)
 (heredoc_body)
] @string @nospell

; Don't spell check shebang lines
((program . (comment) @preproc)
  (#match? @preproc "^#!/")) @nospell
