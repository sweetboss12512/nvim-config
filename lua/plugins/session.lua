local util = require("util")

local function get_session_name()
    local resession = require("resession")
    local session_name = resession.get_current()
    return session_name or util.get_git_branch()
end

local auto_save_session = true
return {
    "stevearc/resession.nvim",
    -- priority = 500000,
    lazy = false,
    config = function()
        local resession = require("resession")
        resession.setup({
            autosave = { enabled = false },
            dir = "sessions",
            extensions = {
                overseer = {
                    -- Only save tasks that are still running.
                    ---@type overseer.Status
                    status = "RUNNING",
                },
                quickfix = {},
            },
        })

        vim.keymap.set("n", "<leader>sw", function()
            local session_name = vim.fn.input("Session name: ")

            if string.len(session_name) == 0 then
                session_name = get_session_name()
            end

            resession.save(session_name)
        end, { desc = "Save session" })

        vim.keymap.set("n", "<leader>so", function()
            resession.load(get_session_name())
        end, { desc = "Restore last session" })
        vim.keymap.set("n", "<leader>sO", resession.load, { desc = "Restore Session (Manual)" })
        vim.keymap.set("n", "<leader>sd", resession.delete, { desc = "Delete session" })
        vim.keymap.set("n", "<leader>Q", function()
            auto_save_session = false
            vim.cmd("qa")
        end, { desc = "Exit without saving session" })

        -- vim.api.nvim_create_autocmd("VimEnter", {
        -- 	callback = function()
        -- 		-- Only load the session if nvim was started with no args
        -- 		if vim.fn.argc(-1) == 0 then
        -- 			resession.load(util.get_git_branch(), { dir = "dirsession", silence_errors = true })
        --
        -- 			vim.cmd("Gitsigns attach") -- Thse aren't being autoloaded for some reason?
        -- 			vim.cmd("UfoAttach")
        -- 		end
        -- 	end,
        -- })

        vim.api.nvim_create_autocmd("VimLeavePre", {
            callback = function()
                if not auto_save_session then
                    return
                end

                resession.save(get_session_name(), { notify = false })
            end,
        })
    end,
}
