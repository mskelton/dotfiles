;; extends

;; styled.`<css>`, css.`<css>`, keyframes.`<css>`
(call_expression 
  function: (identifier) @_name
    (#match? @_name "^(css|styled|keyframes)$")
  arguments: (template_string) @emotion)

;; styled(Component)`<css>`
(call_expression 
  function: (call_expression
    function: (identifier) @_name
      (#eq? @_name "styled"))
  arguments: (template_string) @emotion)
