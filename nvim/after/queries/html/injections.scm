; lit-html style template interpolation
((attribute
  (quoted_attribute_value (attribute_value) @javascript))
  (#match? @javascript "\\$\\{")
  (#offset! @javascript 0 2 0 -1))

((attribute
  (attribute_value) @javascript)
  (#match? @javascript "\\$\\{")
  (#offset! @javascript 0 2 0 -2))
