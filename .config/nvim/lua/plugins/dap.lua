return {
	"mfussenegger/nvim-dap",
	config = function ()
		local dap = require("dap")
		dap.defaults.fallback = {
			force_external_terminal = true,
			external_terminal = { command = "/bin/wezterm"; args = { "start --" }; }
		}

		-- Keymaps
		vim.keymap.set("n", "<leader>dr", "<cmd>lua require('dap').continue()<cr>")

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
	end
}
