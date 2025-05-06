return {
    "ibhagwan/fzf-lua",
    -- enabled = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "FzfLua" },
    keys = {
        { "<leader>ff", "<cmd>FzfLua files<cr>" },
        { "<leader>fb", "<cmd>FzfLua buffers<cr>" },
        { "<leader>fw", "<cmd>FzfLua live_grep_resume<cr>" },
        { "<leader>fW", "<cmd>FzfLua grep_last<cr>" },
        { "<leader>fh", "<cmd>FzfLua helptags<cr>" },
        { "<leader>fr", "<cmd>FzfLua oldfiles<cr>" },
        { "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>" },
        { "<leader>fQ", "<cmd>FzfLua quickfix_stack<cr>" },
        { "<leader>'", "<cmd>FzfLua resume<cr>" },
        { "<leader>fd", "<cmd>FzfLua zoxide<cr>" },
        {
            "<leader>fD",
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
            desc = "Open Directory (Fzf)",
        },
        {
            "<leader>fD",
            function()
                local fzf_lua = require("fzf-lua")
                fzf_lua.zoxide({
                    -- scope = "win", -- Fork :/
                    actions = {
                        ["default"] = function(selected, opts)
                            local cwd = selected[1]:match("[^\t]+$") or selected[1]
                            require("fzf-lua.actions").file_edit({ cwd }, opts)
                        end,
                    },
                })
            end,
            desc = "Open directory with Zoxide",
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

            zoxide = {
                actions = {
                    enter = function(selected, opts) -- Really annoying there's no TCD action.
                        local path = require("fzf-lua.path")
                        local uv = vim.uv or vim.loop
                        local utils = require("fzf-lua.utils")
                        local cwd = selected[1]:match("[^\t]+$") or selected[1]
                        if opts.cwd then
                            cwd = path.join({ opts.cwd, cwd })
                        end
                        local git_root = opts.git_root and path.git_root({ cwd = cwd }, true) or nil
                        cwd = git_root or cwd
                        if uv.fs_stat(cwd) then
                            vim.cmd("tcd " .. cwd)
                            utils.info(("tcd set to %s'%s'"):format(git_root and "git root " or "", cwd))
                        else
                            utils.warn(("Unable to set tcd to '%s', directory is not accessible"):format(cwd))
                        end
                    end,
                },
            },
        })
    end,
    init = function()
        require("fzf-lua").register_ui_select()
    end,
}
