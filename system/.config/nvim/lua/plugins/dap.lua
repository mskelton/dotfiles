--- @vs-reviewed
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	keys = {
		{
			"<F1>",
			function()
				require("dap").step_into()
			end,
			mode = "n",
			desc = "Debug: Step Into",
		},
		{
			"<F2>",
			function()
				require("dap").step_over()
			end,
			mode = "n",
			desc = "Debug: Step Over",
		},
		{
			"<F3>",
			function()
				require("dap").step_out()
			end,
			mode = "n",
			desc = "Debug: Step Out",
		},
		{
			"<F5>",
			function()
				require("dap.ext.vscode").load_launchjs()
				require("dap").continue()
			end,
			mode = "n",
			desc = "Debug: Start/Continue",
		},
		{
			"<F7>",
			function()
				require("dapui").toggle()
			end,
			mode = "n",
			desc = "Debug: See last session result",
		},
		{
			"<leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
			mode = "n",
			desc = "Debug: Toggle Breakpoint",
		},
		{
			"<leader>B",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			mode = "n",
			desc = "Debug: Set Breakpoint",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("nvim-dap-virtual-text").setup({})

		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		dap.adapters.go = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.exepath("dlv"),
				args = { "dap", "-l", "127.0.0.1:${port}" },
			},
		}
	end,
}
