; extends

; Statements
(import_statement (import_clause) @decl.inner) @decl.outer
(expression_statement (_) @decl.inner) @decl.outer
(return_statement (_) @decl.inner) @decl.outer

; Declarations
(lexical_declaration
  (variable_declarator
    name: (_)
    value: (_) @decl.inner)) @decl.outer


; Jest/Playwright Tests
(expression_statement
  (call_expression
    function: (identifier) @_type
    arguments: (arguments
                 (arrow_function
                   body: (statement_block . "{" . (_) @_start @_end (_)? @_end . "}")))
    (#match? @_type "^(x?it|test)$")
    (#make-range! "test.inner" @_start @_end))) @test.outer


(expression_statement
  (call_expression
    function: (member_expression
                object: (identifier) @test.type)
    arguments: (arguments
                 (arrow_function
                   body: (statement_block . "{" . (_) @_start @_end (_)? @_end . "}")))
    (#match? @_type "^(x?it|test)$")
    (#make-range! "test.inner" @_start @_end))) @test.outer
