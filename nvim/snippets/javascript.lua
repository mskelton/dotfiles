--- @diagnostic disable: undefined-global
local utils = require("core.utils")

return {
	parse("nd", "undefined"),
	-- Const variables
	parse("map", "const $1 = new Map([\n\t$0\n])"),
	parse("set", "const $1 = new Set([\n\t$0\n])"),
	-- Comment
	parse("bc", "/** $0 */"),
	-- Functions
	parse("fn", "function $1($2) {\n\t$0\n}"),
	parse("efn", "export function $1($2) {\n\t$0\n}"),
	s(
		"afn",
		fmt("() => {}", {
			c(1, {
				sn(nil, { i(1), t("") }),
				sn(nil, { t({ "{", "\t" }), i(1), t({ "", "}" }) }),
			}),
		})
	),
	-- Utility functions
	parse("cl", "console.log($1)$0"),
	parse("prom", "return new Promise((resolve, reject) => {\n\t$0\n})"),
	parse("timeout", "setTimeout(() => {$2}, ${1:1000}"),
	parse("interval", "setInterval(() => {$2}, ${1:1000}"),
	parse("sleep", "await new Promise((r) => setTimeout(r, ${1:1000}))"),
	-- Imports
	parse("imr", "import React from 'react'"),
	parse("imt", "import { render, screen } from '@testing-library/react'"),
	parse("imu", "import userEvent from '@testing-library/user-event'"),
	parse("ime", "import * as ESTree from 'estree'"),
	-- React
	s(
		"rus",
		fmt("const [{}, set{}] = useState({})", {
			i(1, "value"),
			f(function(args)
				return utils.capitalize(args[1][1])
			end, { 1 }),
			i(0),
		})
	),
	s(
		"rue",
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
	-- Test
	parse("desc", "describe('$1', () => {\n\t$0\n})"),
	parse("test", "test('$1', async () => {\n\t$0\n})"),
	-- Playwright
	parse("pdesc", "test.describe('$1', () => {\n\t$3\n})\n\n$0"),
	parse("ptest", "test('$1', async ({ ${2:page} }) => {\n\t$3\n})\n\n$0"),
	parse("pbe", "test.beforeEach(async ({ ${1:page} }) => {\n\t$2\n})\n\n$0"),
	parse("pba", "test.beforeAll(async ($1) => {\n\t$2\n})\n\n$0"),
	parse("pae", "test.afterEach(async ($1) => {\n\t$2\n})\n\n$0"),
	parse("paa", "test.afterAll(async ($1) => {\n\t$2\n})\n\n$0"),
}
