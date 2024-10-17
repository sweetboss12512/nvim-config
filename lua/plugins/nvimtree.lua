local icons = require("config.icons")

local function on_attach(bufnr)
	local function opts(desc)
		return {
			desc = "nvim-tree: " .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true,
		}
	end

	local api = require("nvim-tree.api")
	local keymap = vim.keymap.set
	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set("n", "d", api.fs.trash, opts("Trash"))
	vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))

	keymap("n", "<LeftRelease>", function()
		local node = api.tree.get_node_under_cursor()

		if node.nodes ~= nil then
			api.node.open.edit()
		end
	end, opts("Open Directory"))
end

return {
	"nvim-tree/nvim-tree.lua",
	-- enabled = false,
	enabled = vim.g.vscode == nil,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	-- keys = {
	-- 	{ "\\", "<cmd>NvimTreeToggle .<CR>" },
	-- },
	config = function()
		local trash_command

		-- This isn't installed by default!
		if vim.fn.has("win32") == 1 then
			trash_command = "recycle-bin.exe"
		elseif vim.fn.has("unix") then
			trash_command = "trash"
		end

		require("nvim-tree").setup({
			on_attach = on_attach,
			trash = {
				cmd = trash_command,
			},
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 35,
				adaptive_size = false,
				side = "left",
				preserve_window_proportions = true,
			},
			renderer = {
				group_empty = true,
				root_folder_label = false,
				icons = {
					web_devicons = {
						file = {
							enable = true,
							color = true,
						},
						folder = {
							enable = false,
							color = true,
						},
					},
					git_placement = "after",
					glyphs = {
						default = icons.file,
						folder = {
							arrow_open = "",
							arrow_closed = "",
							default = icons.folder.close,
							open = icons.folder.open,
							empty = icons.folder.empty,
							empty_open = icons.folder.empty_open,
							symlink = icons.folder.symlink,
							symlink_open = icons.folder.symlink_open,
						},
						git = {
							unstaged = "[M]", --icons.git.unstaged,
							staged = "[A]", --icons.git.staged,
							unmerged = icons.git.conflict,
							renamed = icons.git.renamed,
							untracked = "[U]", -- icons.git.untracked,
							deleted = icons.git.deleted,
							ignored = icons.git.ignored,
						},
					},
				},
			},
			filters = {
				dotfiles = false,
				git_ignored = false,
			},
		})

		vim.keymap.set("n", "\\", "<cmd>NvimTreeToggle .<CR>")
		-- vim.cmd(":NvimTreeOpen")
	end,
}
