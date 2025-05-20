local icons = require("config.icons")

return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- enabled = false,
    lazy = false,
    keys = {
        { "-", "<cmd>Oil<cr>", desc = "Open Oil Explorer" },
        { "<leader>-", "<cmd>Oil .<cr>", desc = "Open Oil Explorer (Cwd)" },
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
            ["<localleader>f"] = {
                function()
                    local oil = require("oil")
                    local cwd = oil.get_current_dir()
                    require("fzf-lua").files({
                        cwd = cwd,
                    })
                end,
                mode = "n",
                desc = "Fzf current directory",
            },
            ["~"] = {
                "actions.cd",
                opts = { scope = "win" },
            },
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
