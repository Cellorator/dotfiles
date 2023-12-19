return {
	"mfussenegger/nvim-dap",
	dependencies = { "rcarriga/nvim-dap-ui" },
	config = function ()
		local dap = require("dap")

		-- Keymaps
		vim.keymap.set("n", "<leader>dr", "<cmd>DapContinue<cr>")
		vim.keymap.set("n", "<leader>dx", "<cmd>DapTerminate<cr>")
		vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>")

		-- Setup
		local godot_adapter = {
			type = "server",
			host = "127.0.0.1",
			port = 6006
		}
		local godot_config = {
			{
				type = "godot",
				request = "launch",
				name = "Launch scene",
				project = "${workspaceFolder}",
				launch_scene = true,
			},
		}

		dap.adapters = {
			godot = godot_adapter,
		}
		dap.configurations = {
			gdscript = godot_config,
		}

		-- Dapui Setup
		local dapui = require("dapui")
		dapui.setup()

		-- Automatically open and close dapui
		-- local dapui_open = function () dapui.open() end
		-- local dapui_close = function () dapui.close() end
		local dapui_open = function () dap.repl.open() end
		local dapui_close = function () dap.repl.close() end
		dap.listeners.after.event_initialized["dapui_config"] = dapui_open
		dap.listeners.before.event_event_terminated["dapui_config"] = dapui_close
		dap.listeners.before.event_exited["dapui_config"] = dapui_close
	end
}
