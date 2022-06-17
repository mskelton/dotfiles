local utils = require("core.utils")

return {
	parse("cl", "console.log($1)$0"),
	parse("prom", "return new Promise((resolve, reject) => {", "\t$0", "})"),
	parse("tout", "setTimeout(() => {$2}, ${1:1000}"),
	-- React
	parse("imr", "import React from 'react'"),
	s(
		"useState",
		fmt("const [{}, set{}] = useState({})", {
			i(1, "value"),
			d(2, function(args)
				return sn(nil, { t(utils.capitalize(args[1][1])) })
			end, { 1 }),
			i(3),
		})
	),
	s(
		"useEffect",
		fmt(
			[[
        useEffect(() => {{
          {}{}
        }}{})
      ]],
			{
				i(1),
				c(2, {
					sn(nil, { t({ "", "", "\treturn () => " }), i(1) }),
					t(""),
				}),
				c(3, {
					sn(nil, { t(", ["), i(1), t("]") }),
					t(""),
				}),
			}
		)
	),
	-- i18next
	parse("i18n-useTranslation", "const [t] = useTranslation()"),
	s(
		"i18n-t",
		fmt("{}t('{}'){}", {
			c(1, { t("{"), t("") }),
			i(2),
			m(1, "^{$", "}", ""),
		})
	),
	-- Playwright
	parse("pw-describe", "test.describe('$1', () => {\n\t$3\n})\n\n$0"),
	parse("pw-test", "test('$1', async ({ ${2:page} }) => {\n\t$3\n})\n\n$0"),
	parse("pw-beforeEach", "test.beforeEach('$1', async ({ ${2:page} }) => {\n\t$3\n})\n\n$0"),
	parse("pw-beforeAll", "test.beforeEach('$1', async ($2) => {\n\t$3\n})\n\n$0"),
	parse("pw-afterAll", "test.beforeEach('$1', async ($2) => {\n\t$3\n})\n\n$0"),
	-- Emotion
	parse("ces", "const ${1:button}Style = css`\n\t$0\n`"),
}
