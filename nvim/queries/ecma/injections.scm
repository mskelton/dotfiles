(comment) @jsdoc
(comment) @comment
(regex_pattern) @regex

; {lang}`<{lang}>`
(call_expression
 function: ((identifier) @injection.language
  (#match? @injection.language "^(hbs|html)"))
 arguments: ((template_string) @injection.content
  (#offset! @injection.content 0 1 0 -1)))

; gql`<{lang}>`
(call_expression
 function: ((identifier) @_name
  (#match? @_name "gql"))
 arguments: ((template_string) @graphql
  (#offset! @graphql 0 1 0 -1)))


; css`<css>`, keyframes`<css>`
(call_expression
  function: (identifier) @_name
    (#match? @_name "^(css|keyframes)")
  arguments: ((template_string) @styled
  (#offset! @styled 0 1 0 -1)))

; styled.div`<css>`
(call_expression
 function: (member_expression
   object: (identifier) @_name
     (#eq? @_name "styled"))
 arguments: ((template_string) @styled
  (#offset! @styled 0 1 0 -1)))

; styled(Component)`<css>`
(call_expression
 function: (call_expression
   function: (identifier) @_name
     (#eq? @_name "styled"))
 arguments: ((template_string) @styled
  (#offset! @styled 0 1 0 -1)))
