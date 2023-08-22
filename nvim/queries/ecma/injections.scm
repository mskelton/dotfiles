(comment) @jsdoc
(comment) @comment
(regex_pattern) @regex

; {lang}`<{lang}>`
(call_expression
 function: ((identifier) @injection.language
  (#match? @injection.language "^(gql|hbs|html)"))
 arguments: ((template_string) @injection.content
  (#offset! @injection.content 0 1 0 -1)))
