local eslint = {
	icon = "",
	color = "#8080F2",
	cterm_color = "60",
	name = "Eslint",
}

local typescript = {
	icon = "",
	color = "#519aba",
	cterm_color = "67",
	name = "Ts",
}

local babel = {
	icon = "",
	color = "#f9dc3e",
	cterm_color = "179",
	name = "Babel",
}

local tailwind = {
	icon = "󱏿",
	color = "#38bdf8",
	cterm_color = "75",
	name = "Tailwind",
}

local makefile = {
	icon = "",
	color = "#767676",
	cterm_color = "243",
	name = "Makefile",
}

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		{
			"nvim-tree/nvim-web-devicons",
			opts = {
				override = {
					[".eslintrc"] = eslint,
					[".eslintignore"] = eslint,
					["eslint.config.js"] = eslint,
					["eslint.config.cjs"] = eslint,
					["eslint.config.mjs"] = eslint,
					["cts"] = typescript,
					["mts"] = typescript,
					[".babelrc"] = babel,
					["babel.config.js"] = babel,
					["babel.config.cjs"] = babel,
					["babel.config.mjs"] = babel,
					["tailwind.config.js"] = tailwind,
					["tailwind.config.cjs"] = tailwind,
					["tailwind.config.mjs"] = tailwind,
					["Makefile"] = makefile,
				},
			},
		},
	},
	keys = {
		{
			"<leader>fd",
			"<cmd>NvimTreeFindFileToggle!<cr>",
			mode = { "n", "v" },
			desc = "Toggle file tree",
		},
	},
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	config = function()
		local api = require("nvim-tree.api")

		require("nvim-tree").setup({
			trash = {
				cmd = "trash",
			},
			ui = {
				confirm = {
					remove = false,
					trash = false,
				},
			},
			remove_keymaps = true,
			on_attach = function(bufnr)
				local function map(key, cmd, desc)
					vim.keymap.set(
						"n",
						key,
						cmd,
						{ buffer = bufnr, nowait = true, silent = true, desc = desc }
					)
				end

				-- When I open a file to edit, 90% of the time I no longer want the tree
				-- open anymore. If I'm exploring, <Tab> works better to keep focus in
				-- the tree while viewing files.
				local function edit_and_close_tree()
					api.node.open.edit()
					api.tree.close()
				end

				-- The preview command doesn't work when using `on_attach` for reasons
				-- unknown to me.
				local function preview()
					local node = api.tree.get_node_under_cursor()

					if node and node.type == "directory" then
						api.node.open.edit()
					else
						api.node.open.preview()
					end
				end

				map("<cr>", edit_and_close_tree, "Open")
				map("<C-]>", api.tree.change_root_to_node, "CD")
				map("<C-k>", api.node.show_info_popup, "Info")
				map("<C-r>", api.fs.rename_sub, "Rename: Omit filename")
				map("<C-v>", api.node.open.vertical, "Open: Vertical split")
				map("<C-x>", api.node.open.horizontal, "Open: Horizontal split")
				map("<BS>", api.node.navigate.parent_close, "Close directory")
				map("<CR>", edit_and_close_tree, "Open")
				map("<Tab>", preview, "Open preview")
				map(">", api.node.navigate.sibling.next, "Next sibling")
				map("<", api.node.navigate.sibling.prev, "Previous sibling")
				map(".", api.node.run.cmd, "Run command")
				map("-", api.tree.change_root_to_parent, "Up")
				map("a", api.fs.create, "Create")
				map(
					"bmv",
					api.marks.bulk.move,
					"Move all bookmarked nodes into specified location"
				)
				map("c", api.fs.copy.node, "Copy")
				map("[c", api.node.navigate.git.prev, "Previous Git")
				map("]c", api.node.navigate.git.next, "Next Git")
				map("dd", api.fs.remove, "Delete")
				map("D", api.fs.trash, "Trash")
				map("E", api.tree.expand_all, "Expand All")
				map("e", api.fs.rename_basename, "Rename: Basename")
				map("]e", api.node.navigate.diagnostics.next, "Next diagnostic")
				map("[e", api.node.navigate.diagnostics.prev, "Previous diagnostic")
				map("gy", api.fs.copy.absolute_path, "Copy absolute path")
				map("H", api.tree.toggle_hidden_filter, "Toggle dotfiles")
				map("I", api.tree.toggle_gitignore_filter, "Toggle Git ignore")
				map("J", api.node.navigate.sibling.last, "Last sibling")
				map("K", api.node.navigate.sibling.first, "First sibling")
				map("m", api.marks.toggle, "Toggle bookmark")
				map("o", edit_and_close_tree, "Open")
				map("p", api.fs.paste, "Paste")
				map("P", api.node.navigate.parent, "Parent directory")
				map("q", api.tree.close, "Close")
				map("r", api.fs.rename, "Rename")
				map("R", api.tree.reload, "Refresh")
				map("s", api.node.run.system, "Run system")
				map("W", api.tree.collapse_all, "Collapse")
				map("x", api.fs.cut, "Cut")
				map("y", api.fs.copy.filename, "Copy name")
				map("Y", api.fs.copy.relative_path, "Copy relative path")
			end,
		})
	end,
}
