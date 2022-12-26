; extends

; Don't spell check strings
(string) @string @nospell

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
