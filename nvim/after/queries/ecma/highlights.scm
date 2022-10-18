; extends

; Emotion

; styled.div`<css>`
(call_expression
  function: (member_expression
    object: (identifier) @_name
      (#eq? @_name "styled"))
  arguments: (template_string) @emotion)

; styled(Component)`<css>`
(call_expression
  function: (call_expression
    function: (identifier) @_name
      (#eq? @_name "styled"))
  arguments: (template_string) @emotion)

; css`<css>`, keyframes`<css>`
(call_expression
  function: (identifier) @_name
    (#match? @_name "^(css|keyframes)")
  arguments: (template_string) @emotion)
