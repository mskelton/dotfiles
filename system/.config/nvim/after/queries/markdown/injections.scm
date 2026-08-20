; extends

; MDX imports
((paragraph) @injection.content
  (#match? @injection.content "^(import|export).+$")
  (#set! injection.include-children)
  (#set! injection.language "javascript"))
