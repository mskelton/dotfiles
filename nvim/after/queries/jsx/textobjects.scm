; extends

; JSX attributes
(jsx_attribute) @tag.attribute.outer
(jsx_attribute (jsx_expression (_) @tag.attribute.inner))
(jsx_attribute (string (string_fragment) @tag.attribute.inner))
