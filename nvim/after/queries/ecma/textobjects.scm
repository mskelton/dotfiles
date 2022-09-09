;; Statements
(import_statement (import_clause) @statement.inner) @statement.outer
(expression_statement (_) @statement.inner) @statement.outer
(return_statement (_) @statement.inner) @statement.outer

;; Declarations
(lexical_declaration
  (variable_declarator
    name: (identifier)
    value: (_) @declaration.inner)) @declaration.outer
