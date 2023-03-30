; extends

; Statements
(import_statement (import_clause) @statement.inner) @statement.outer
(expression_statement (_) @statement.inner) @statement.outer
(return_statement (_) @statement.inner) @statement.outer

; Declarations
(lexical_declaration
  (variable_declarator
    name: (_)
    value: (_) @declaration.inner)) @declaration.outer


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
