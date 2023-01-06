; extends

(unit) @variable.builtin

; Hex colors
(color_value) @string.special
"#" @string.special

; Class names and pseudo-elements
(class_name) @string
(pseudo_class_selector (class_name) @keyword)
