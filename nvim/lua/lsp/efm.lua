local M = {}

--- Modifies the config
--- @param tbl table
--- @param extend table
local function with(tbl, extend)
	return vim.tbl_extend("force", tbl, extend)
end

M.config = function()
	local fish_indent = require("efmls-configs.formatters.fish_indent")
	local rustfmt = require("efmls-configs.formatters.rustfmt")
	local shfmt = require("efmls-configs.formatters.shfmt")
	local stylua = require("efmls-configs.formatters.stylua")

	local prettierd = with(require("efmls-configs.formatters.prettier_d"), {
		formatCommand = "prettierd '${INPUT}' ${--range-start=charStart} ${--range-end=charEnd}",
		env = {
			"PRETTIERD_LOCAL_PRETTIER_ONLY=true",
		},
	})

	local biome = with(require("efmls-configs.formatters.biome"), {
		requireMarker = true,
	})

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
		["typescriptreact"] = { prettierd },
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
			languages = languages,
		},
	}
end

return M
