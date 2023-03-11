; extends

; Don't spell check strings
(string) @string @nospell

; Only apply the `@string` capture to non-injected languages
((template_string) @string (#not-injected? @string styled css keyframes gql html))

; Highlight template string symbols
(template_string "`" @string)

