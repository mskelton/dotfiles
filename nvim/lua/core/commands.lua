-- Run GitHub CLI (gh) command
vim.api.nvim_create_user_command("H", "!gh <args>", { nargs = "*" })

-- Format JSON with jq
vim.api.nvim_create_user_command("JsonFormat", ":%!jq .", {})

-- Minify JSON with jq
vim.api.nvim_create_user_command("JsonMinify", ":%!jq -c .", {})

-- Copy stringified JSON to clipboard
vim.api.nvim_create_user_command(
	"JsonCopy",
	[[:silentw !jq -c . | sed "s/\"/\\\\\"/g" | tr -d "\n" | pbcopy]],
	{}
)

-- Create an ISC license in a project
vim.api.nvim_create_user_command("License", "!gh license isc", {})

-- Search/replace type commands
vim.api.nvim_create_user_command("RemoveEmptyLines", ":g/^$/d", { bar = true })
vim.api.nvim_create_user_command(
	"RemoveTrailingWhitespace",
	[[:%s/\s\+$//e]],
	{ bar = true }
)
vim.api.nvim_create_user_command(
	"UniqueLines",
	":RemoveEmptyLines | sort u",
	{ bar = true }
)

-- Browse a URL in the default browser. Needed for vim-fugitive
-- Search/replace type commands
vim.api.nvim_create_user_command(
	"Browse",
	"silent !open <args>",
	{ nargs = "*" }
)

-- Load Flashlight results into quickfix list
vim.api.nvim_create_user_command(
	"Flashlight",
	'cexpr system("flashlight --format=vi " . <q-args>)',
	{ nargs = "*" }
)

--- Returns a function that copies the given expanded expression to the clipboard
--- @param expression string
local function copy(expression)
	return function()
		vim.cmd(':let @+ = expand("' .. expression .. '")')
	end
end

-- Copy file path to the clipboard
vim.api.nvim_create_user_command("CopyPath", copy("%"), { bar = true })
vim.api.nvim_create_user_command("CopyAbsPath", copy("%:p"), { bar = true })
vim.api.nvim_create_user_command("CopyDir", copy("%:h"), { bar = true })
vim.api.nvim_create_user_command("CopyAbsDir", copy("%:p:h"), { bar = true })
