;; Statements
(import_statement (import_clause) @statement.inner) @statement.outer
(expression_statement (_) @statement.inner) @statement.outer
(return_statement (_) @statement.inner) @statement.outer

;; Declarations
(lexical_declaration (_) @declaration.inner) @declaration.outer
