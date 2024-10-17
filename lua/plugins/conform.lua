return {
	"stevearc/conform.nvim",
	lazy = false,
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				luau = { "stylua" },
			},
			{
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_fallback = true,
				},
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", { -- Auto format
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})

		vim.keymap.set("n", "<F3>", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end)
	end,
}
