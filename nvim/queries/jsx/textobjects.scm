; inherits: ecma

; JSX tags
(jsx_element) @tag.outer
(jsx_self_closing_element) @tag.outer @tag.inner
((jsx_element open_tag: (_) . (_) @_child . close_tag: (_))
 (#make-range! "tag.inner" @_child @_child))
((jsx_element open_tag: (_) . (_) @_start (_) @_end . close_tag: (_))
 (#make-range! "tag.inner" @_start @_end))

; JSX attributes
(jsx_attribute) @parameter.outer
(jsx_attribute (jsx_expression (_) @parameter.inner))
(jsx_attribute (string (string_fragment) @parameter.inner))
