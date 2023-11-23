local M = {}

M.config = function()
	local biome = require("efmls-configs.formatters.biome")
	local fish_indent = require("efmls-configs.formatters.fish_indent")
	local prettierd = require("efmls-configs.formatters.prettier_d")
	local rustfmt = require("efmls-configs.formatters.rustfmt")
	local shfmt = require("efmls-configs.formatters.shfmt")
	local stylua = require("efmls-configs.formatters.stylua")

	local dtsfmt = {
		formatCommand = "dtsfmt --stdin '${INPUT}'",
		formatStdin = true,
	}

	local swiftformat = {
		formatCommand = "swiftformat --stdinpath '${INPUT}'",
		formatStdin = true,
	}

	local languages = {
		["bash"] = { shfmt },
		["css"] = { prettierd },
		["fish"] = { fish_indent },
		["graphql"] = { prettierd },
		["handlebars"] = { prettierd },
		["html"] = { prettierd },
		["javascript"] = { prettierd, biome },
		["javascriptreact"] = { prettierd, biome },
		["json"] = { prettierd, biome },
		["jsonc"] = { prettierd, biome },
		["less"] = { prettierd },
		["lua"] = { stylua },
		["markdown"] = { prettierd },
		["markdown.mdx"] = { prettierd },
		["rust"] = { rustfmt },
		["scss"] = { prettierd },
		["sh"] = { shfmt },
		["svelte"] = { prettierd },
		["svg"] = { prettierd },
		["typescript"] = { prettierd, biome },
		["typescriptreact"] = { prettierd, biome },
		["vue"] = { prettierd },
		["yaml"] = { prettierd },
		["swift"] = { swiftformat },
		["dts"] = { dtsfmt },
	}

	return {
		filetypes = vim.tbl_keys(languages),
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
		},
		settings = {
			rootMarkers = { ".git/" },
			languages = languages,
		},
	}
end

return M
