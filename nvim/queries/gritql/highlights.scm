[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
 "where"
 "limit"
 "sequential"
 "includes"
 "or"
] @keyword

[
  "=>"
  "<:"
] @operator

[
  "+"
  "-"
  "*"
  "/"
  "%"
  "="
  "=>"
  "+="
  ">"
  "<"
  ">="
  "<="
  "!="
  "=="
  "<:"
] @operator

[
 "."
 ","
 ":"
 ";"
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
 "after"
 "and"
 "any"
 "as"
 "before"
 "bubble"
 "contains"
 "else"
 "every"
 "if"
 "includes"
 "like"
 "limit"
 "maybe"
 "multifile"
 "not"
 "or"
 "orelse"
 "sequential"
 "some"
 "where"
 "within"
] @keyword

; Keywords
(undefined) @keyword
(top) @keyword
(bottom) @keyword
(version) @keyword

; Comments
(comment) @comment

; Language
(langdecl) @keyword
(langdecl (languageName) @constant)
(langdecl (language_flavor) @constant)

; Strings
(codeSnippet (backtickSnippet) @string)
(stringConstant) @string
(regex) @string.regex
(snippetRegex) @string.special
(codeSnippet) @string.special

; Numbers
(intConstant) @number
(signedIntConstant) @number
(doubleConstant) @number

; Boolean
(booleanConstant) @boolean

; Functions
(patternDefinition) @function.definition
(predicateDefinition) @function.definition
(functionDefinition) @function.definition
(foreignFunctionDefinition) @function.definition

; Variables
(variable) @variable
(annotation) @variable
