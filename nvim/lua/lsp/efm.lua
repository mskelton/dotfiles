local M = {}

M.config = function()
	local dprint = require("efmls-configs.formatters.dprint")
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
		["javascript"] = { prettierd, dprint },
		["javascriptreact"] = { prettierd, dprint },
		["json"] = { prettierd, dprint },
		["jsonc"] = { prettierd, dprint },
		["less"] = { prettierd },
		["lua"] = { stylua },
		["markdown"] = { prettierd, dprint },
		["markdown.mdx"] = { prettierd, dprint },
		["rust"] = { rustfmt },
		["scss"] = { prettierd },
		["sh"] = { shfmt },
		["svelte"] = { prettierd },
		["svg"] = { prettierd },
		["typescript"] = { prettierd, dprint },
		["typescriptreact"] = { prettierd, dprint },
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
