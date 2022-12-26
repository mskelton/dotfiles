local M = {}

M.ecma_injections = [[

(comment) @jsdoc
(comment) @comment
(regex_pattern) @regex

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

]]

function M.queries()
	vim.treesitter.query.set_query("javascript", "injections", M.ecma_injections)
	vim.treesitter.query.set_query("typescript", "injections", M.ecma_injections)
	vim.treesitter.query.set_query("tsx", "injections", M.ecma_injections)
end

return M
