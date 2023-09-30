(comment) @jsdoc
(comment) @comment
(regex_pattern) @regex

; {lang}`<{lang}>`
(call_expression
 function: ((identifier) @injection.language
  (#match? @injection.language "^(gql|hbs|html)"))
 arguments: ((template_string) @injection.content
  (#offset! @injection.content 0 1 0 -1)))

; css`<css>`, keyframes`<css>`
(call_expression
  function: (identifier) @_name
    (#match? @_name "^(css|keyframes)")
  arguments: ((template_string) @styled
  (#offset! @styled 0 1 0 -1)))
