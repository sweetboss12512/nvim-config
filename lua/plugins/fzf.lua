local function directory_edit(selected, opts)
    local cwd = selected[1]:match("[^\t]+$") or selected[1]
    require("fzf-lua.actions").file_edit({ cwd }, opts)
end

return {
    "ibhagwan/fzf-lua",
    -- enabled = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "FzfLua" },
    keys = {
        { "<leader>ff", "<cmd>FzfLua files<cr>" },
        { "<leader>fb", "<cmd>FzfLua buffers<cr>" },
        { "<leader>fw", "<cmd>FzfLua live_grep<cr>" },
        { "<leader>fW", "<cmd>FzfLua grep_last<cr>" },
        { "<leader>fh", "<cmd>FzfLua helptags<cr>" },
        { "<leader>fr", "<cmd>FzfLua oldfiles<cr>" },
        { "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>" },
        { "<leader>fQ", "<cmd>FzfLua quickfix_stack<cr>" },
        { "<leader>'", "<cmd>FzfLua resume<cr>" }, -- helix omg
        {
            "<leader>fd",
            function()
                local fzf_lua = require("fzf-lua")
                local cmd = "fd . --type d"
                fzf_lua.fzf_exec(cmd, {
                    prompt = "Open Directory> ",
                    actions = {
                        ["default"] = require("fzf-lua.actions").file_edit,
                    },
                })
            end,
            desc = "Open Directory",
        },
        {
            "<leader>fz",
            function()
                local fzf_lua = require("fzf-lua")
                fzf_lua.zoxide({
                    -- scope = "win", -- Fork :/
                    actions = {
                        ["default"] = directory_edit,
                        -- ["<C-t>"] = directory_edit,
                    },
                })
            end,
            desc = "Open directory (Zoxide)",
        },

        -- git
        { "<leader>gs", "<cmd>FzfLua git_status<cr>" },
        { "<leader>gS", "<cmd>FzfLua git_stash<cr>" }, -- This sucks
        { "<leader>gb", "<cmd>FzfLua git_branches<cr>" },
        { "<leader>gl", "<cmd>FzfLua git_commits<cr>" },
        { "<leader>gL", "<cmd>FzfLua git_bcommits<cr>" },

        { "grr", "<cmd>FzfLua lsp_references<cr>", desc = "Lsp References (Fzf)" },
        { "<C-f>", "<cmd>FzfLua complete_path<cr>", mode = "i" },
    },
    config = function()
        local actions = require("fzf-lua.actions")
        require("fzf-lua").setup({
            { "telescope" },
            fzf_opts = { ["--cycle"] = true },
            files = {
                cwd_prompt = false,
                actions = { ["ctrl-g"] = actions.toggle_ignore },
            },
            grep = {
                actions = {
                    ["ctrl-r"] = actions.toggle_ignore,
                    ["ctrl-g"] = { actions.grep_lgrep },
                },
                glob_flag = "--glob", -- for case sensitive globs use '--glob'
            },

            -- previewers = {
            --     builtin = {
            --         extensions = {
            --             ["png"] = { "wezterm", "imgcat", "{file}" },
            --         },
            --     },
            -- },
        })
    end,
    init = function()
        require("fzf-lua").register_ui_select()
    end,
}
