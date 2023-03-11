(comment) @jsdoc
(comment) @comment
(regex_pattern) @regex

; {lang}`<{lang}>`
(call_expression
 function: ((identifier) @language
  (#match? @language "^(gql|hbs|html)"))
 arguments: ((template_string) @content
  (#offset! @content 0 1 0 -1)))
