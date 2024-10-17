return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({
			settings = {
				save_on_toggle = true,
			},
		})

        -- stylua: ignore start
		vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add harpoon mark" })
		vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon quick menu" })

		vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon File 1" })
		vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon File 2" })
		vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon File 3" })
		vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon File 4" })
		-- stylua: ignore end
	end,
}
