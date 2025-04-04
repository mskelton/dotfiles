vim.api.nvim_create_user_command("Gh", "!gh <args>", { nargs = "*" })
vim.api.nvim_create_user_command("Gt", "!gt <args>", { nargs = "*" })

--- Format JSON with jq
vim.api.nvim_create_user_command("JsonFormat", ":%!jq .", {})

--- Minify JSON with jq
vim.api.nvim_create_user_command("JsonMinify", ":%!jq -c .", {})

--- Copy stringified JSON to clipboard
vim.api.nvim_create_user_command(
	"JsonCopy",
	[[:silentw !jq -c . | sed "s/\"/\\\\\"/g" | tr -d "\n" | pbcopy]],
	{}
)

--- Create an ISC license in a project
vim.api.nvim_create_user_command("License", "!gh license isc", {})

--- Search/replace type commands
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

--- Browse a URL in the default browser. Needed for vim-fugitive
--- Search/replace type commands
vim.api.nvim_create_user_command("Browse", function(args)
	require("core.utils").open_url(args.args)
end, { nargs = "*" })

--- Load `imports` command results into quickfix list
vim.api.nvim_create_user_command("Imports", function(args)
	require("core.utils").run_system_to_qfix(
		vim.list_extend({ "imports", "--format", "vi" }, args.fargs)
	)
end, { nargs = "*" })

--- Load `tags` command results into quickfix list
vim.api.nvim_create_user_command("Tags", function(args)
	require("core.utils").run_system_to_qfix(
		vim.list_extend({ "tags", "--format", "vi" }, args.fargs)
	)
end, { nargs = "*" })

--- Returns a function that copies the given expanded expression to the clipboard
--- @param expression string
local function copy(expression)
	return function()
		vim.cmd(':let @+ = expand("' .. expression .. '")')
	end
end

--- Copy file path to the clipboard
vim.api.nvim_create_user_command("CopyPath", copy("%"), { bar = true })
vim.api.nvim_create_user_command("CopyAbsPath", copy("%:p"), { bar = true })
vim.api.nvim_create_user_command("CopyDir", copy("%:h"), { bar = true })
vim.api.nvim_create_user_command("CopyAbsDir", copy("%:p:h"), { bar = true })

vim.api.nvim_create_user_command("Likewise", function()
	local basename = string.gsub(vim.fn.expand("%:r"), "%..*$", "")

	vim.ui.input({
		prompt = "Likewise",
		default = basename .. ".",
	}, function(new_value)
		if new_value == nil then
			return
		end

		vim.cmd("e " .. new_value)
	end)
end, {
	desc = "Create a file with the same base name and a different extension",
})

vim.api.nvim_create_user_command("ToggleListChars", function()
	local listchars = vim.o.listchars
	local trailer = require("core.utils.trailer")

	if string.match(listchars, "eol") ~= nil then
		vim.o.listchars = trailer.standard
	else
		vim.o.listchars = trailer.verbose
	end
end, {
	desc = "Toggle show all list chars",
})

vim.api.nvim_create_user_command("Exec", function(opts)
	local output = vim.fn.system(opts.args)
	vim.api.nvim_put(vim.fn.split(output, "\n"), "c", true, true)
end, {
	nargs = 1,
	desc = "Execute a shell command and insert the output into the buffer",
	complete = "shellcmd",
})

vim.api.nvim_create_user_command("Quote", function(opts)
	local start_line = opts.line1
	local end_line = opts.line2

	local function quote_line(line)
		local leading_spaces = line:match("^%s*")
		local content = line:match("^%s*(.*)")
		return leading_spaces .. string.format('"%s",', content)
	end

	for line = start_line, end_line do
		local content = vim.fn.getline(line)
		vim.fn.setline(line, quote_line(content))
	end
end, {
	desc = "Quote lines",
	range = true,
})
