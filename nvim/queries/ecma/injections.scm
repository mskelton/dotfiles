(comment) @jsdoc
(comment) @comment
(regex_pattern) @regex

; styled.div`<css>`
(call_expression
 function: (member_expression
   object: (identifier) @_name
     (#eq? @_name "styled"))
 arguments: ((template_string) @styled
  (#offset! @styled 0 1 0 -1)
  (#inject_without_children! @styled)))

; styled(Component)`<css>`
(call_expression
 function: (call_expression
   function: (identifier) @_name
     (#eq? @_name "styled"))
 arguments: ((template_string) @styled
  (#offset! @styled 0 1 0 -1)
  (#inject_without_children! @styled)))

; css`<css>`, keyframes`<css>`
(call_expression
  function: (identifier) @_name
    (#match? @_name "^(css|keyframes)")
  arguments: ((template_string) @styled
    (#offset! @styled 0 1 0 -1)
    (#inject_without_children! @styled)))

; {lang}`<{lang}>`
(call_expression
 function: ((identifier) @language)
 arguments: ((template_string) @content
   (#offset! @content 0 1 0 -1)
   (#inject_without_children! @content)))

