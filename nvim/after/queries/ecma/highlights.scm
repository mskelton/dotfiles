; extends

; Don't spell check strings
(string) @string @nospell

; Only apply the `@string` capture to non-injected languages
((template_string) @string (#not-injected? @string styled css keyframes gql html))

; Highlight template string symbols
(template_string "`" @string)

; Styled components. This is required to make emmet work properly inside
; styled component strings.

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

; css`<css>`, keyframes`<css>`
(call_expression
  function: (identifier) @_name
    (#match? @_name "^(css|keyframes)")
  arguments: ((template_string) @styled
  (#offset! @styled 0 1 0 -1)))
