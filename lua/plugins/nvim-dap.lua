return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"mxsdev/nvim-dap-vscode-js",
		"microsoft/vscode-js-debug",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		dapui.setup()

		require("dap-vscode-js").setup({
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost", "php" },
			debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
		})

		-- dap.adapters["pwa-node"] = {
		-- 	-- type = "server",
		-- 	-- host = "127.0.0.1",
		-- 	-- port = 9229,
		-- 	-- executable = {
		-- 	--   command = "js-debug-adapter",
		-- 	-- },
		-- }

    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = { "/home/berli/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
    }

		for _, language in ipairs({ "typescript", "javascript", "php" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
			dap.configurations.php = {
				{
					type = "php",
					request = "launch",
					name = "Listen for xdebug",
					port = "9003",
					log = false,
					serverSourceRoot = "/srv/www/",
					localSourceRoot = "/home/berli/",
				},
			}
		end

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<leader>dc", dap.continue, {})
	end,
}
