; extends

(unit) @variable.builtin

; Hex colors
(color_value) @constant
"#" @constant

; Class name
(class_name) @type
(class_selector "." @type)

; Pseudo elements (e.g., :first-child, ::before)
(pseudo_class_selector (class_name) @property)
