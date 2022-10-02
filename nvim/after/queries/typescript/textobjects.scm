;; extends

;; Declarations
(type_alias_declaration
  name: (type_identifier)
  value: (_) @declaration.inner) @declaration.outer

(interface_declaration
  name: (type_identifier)
  body: (_) @declaration.inner) @declaration.outer

