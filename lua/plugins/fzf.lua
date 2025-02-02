return {
    "ibhagwan/fzf-lua",
    -- enabled = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "FzfLua" },
    keys = {
        { "<leader>ff", "<cmd>FzfLua files cwd_prompt=false<cr>", desc = "Files (Fzf)" },
        { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers (Fzf)" },
        { "<leader>fw", "<cmd>FzfLua live_grep_resume<cr>", desc = "Live Grep (Fzf)" },
        { "<leader>fW", "<cmd>FzfLua grep_last<cr>", desc = "Grep Last (Fzf)" },
        { "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "Help Pages (Fzf)" },
        { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files (Fzf)" },
        { "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document Symbols (Fzf)" },
        { "<leader>fQ", "<cmd>FzfLua quickfix_stack<cr>", desc = "Document Symbols (Fzf)" },
        { "<leader>fo", "<cmd>FzfLua resume<cr>", desc = "Resume Last Query (Fzf)" },
        { "<C-f>", "<cmd>FzfLua complete_path<cr>", mode = "i" },

        { "<leader>gC", "<cmd>FzfLua git_bcommits<cr>" },
        { "<leader>gs", "<cmd>FzfLua git_status<cr>" },
        { "<leader>gb", "<cmd>FzfLua git_branches<cr>" },
    },
    opts = {
        { "telescope" },
        files = {
            cwd_prompt = false,
        },
    },
    init = function()
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
            require("fzf-lua").register_ui_select()
            vim.ui.select(...)
        end

        -- zoxide vim doesn't support fzf-lua :/
        vim.api.nvim_create_user_command("Z", function()
            require("fzf-lua").fzf_exec("zoxide query -l", {
                prompt = "Zoxide Directory>",
                actions = {
                    default = function(selected)
                        vim.cmd("tcd " .. selected[1])
                    end,
                },
            })
        end, {})
    end,
}
