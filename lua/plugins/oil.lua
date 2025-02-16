local icons = require("config.icons")

--- @param path string
-- local function get_path_relative_to_cwd(path)
-- 	local cwd = vim.fn.getcwd()
-- 	return path:gsub(cwd, ".")
-- end

--- @param winid number
-- local function get_win_title(winid)
-- 	local src_buf = vim.api.nvim_win_get_buf(winid)
-- 	local title = vim.api.nvim_buf_get_name(src_buf)
-- 	local scheme, path = require("oil.util").parse_url(title)
-- 	if require("oil.config").adapters[scheme] == "files" then
-- 		assert(path)
-- 		local fs = require("oil.fs")
--
-- 		title = get_path_relative_to_cwd(fs.posix_to_os_path(path)):gsub("\\", "/")
-- 	end
-- 	return title
-- end

return {
    -- (https://github.com/stevearc/oil.nvim)
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- enabled = false,
    lazy = false,
    keys = {
        -- { "<leader>v", "<cmd>Oil --float<cr>", desc = "Open Oil Explorer" },
        -- { "<leader>V", "<cmd>Oil --float .<cr>", desc = "Open Oil Explorer (Root)" },
        -- { "<leader>v", "<cmd>Oil <cr>", desc = "Open Oil Explorer" },
        -- { "<leader>V", "<cmd>Oil .<cr>", desc = "Open Oil Explorer (Root)" },
        { "-", "<cmd>Oil<cr>", desc = "Open Oil Explorer" },
        { "<leader>-", "<cmd>Oil .<cr>", desc = "Open Oil Explorer (Pwd)" },
    },
    opts = {
        skip_confirm_for_simple_edits = true,
        columns = {
            {
                "icon",
                default_file = icons.file,
                directory = icons.folder.close,
            },
        },
        delete_to_trash = true,
        lsp_file_methods = {
            -- Enable or disable LSP file operations
            enabled = true,
            -- Time to wait for LSP file operations to complete before skipping
            timeout_ms = 1000,
            -- Set to true to autosave buffers that are updated with LSP willRenameFiles
            -- Set to "unmodified" to only save unmodified buffers
            autosave_changes = false,
        },
        keymaps = {
            -- ["q"] = { "actions.close", mode = "n" },
        },
        float = {
            get_win_title = nil,
        },
        view_options = {
            -- Show files and directories that start with "."
            show_hidden = false,
            -- This function defines what is considered a "hidden" file
            is_hidden_file = function()
                -- return vim.startswith(name, ".")
                return false
            end,
            is_always_hidden = function(name)
                return name == ".git" -- .git/ directory
            end,
        },
    },
    -- Don't darking the stuff
    -- init = function()
    --     vim.api.nvim_set_hl(0, "OilHidden", { link = "@text" })
    -- end,
}
