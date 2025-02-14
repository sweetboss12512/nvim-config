return {
    "ibhagwan/fzf-lua",
    -- enabled = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "FzfLua" },
    keys = {
        { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Files (Fzf)" },
        { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers (Fzf)" },
        { "<leader>fw", "<cmd>FzfLua live_grep_resume<cr>", desc = "Live Grep (Fzf)" },
        { "<leader>fW", "<cmd>FzfLua grep_last<cr>", desc = "Grep Last (Fzf)" },
        { "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "Help Pages (Fzf)" },
        { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files (Fzf)" },
        { "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document Symbols (Fzf)" },
        { "<leader>fQ", "<cmd>FzfLua quickfix_stack<cr>", desc = "Document Symbols (Fzf)" },
        { "<leader>fo", "<cmd>FzfLua resume<cr>", desc = "Resume Last Query (Fzf)" },
        { "<leader>fd", "<cmd>FzfLua zoxide<cr>", desc = "Zoxide Results (Fzf)" },
        { "gr", "<cmd>FzfLua lsp_references<cr>", desc = "Zoxide Results (Fzf)" },
        { "<C-f>", "<cmd>FzfLua complete_path<cr>", mode = "i" }, -- Lazy loading breaks this??

        { "<leader>gs", "<cmd>FzfLua git_status<cr>" },
        -- { "<leader>gS", "<cmd>FzfLua git_stash<cr>" },
        { "<leader>gb", "<cmd>FzfLua git_branches<cr>" },
        { "<leader>gl", "<cmd>FzfLua git_commits<cr>" },
        { "<leader>gL", "<cmd>FzfLua git_bcommits<cr>" },
    },
    config = function()
        local actions = require("fzf-lua.actions")
        require("fzf-lua").setup({
            { "telescope" },
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
