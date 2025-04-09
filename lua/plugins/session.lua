local util = require("util")

local function get_session_name()
    local resession = require("resession")
    local session_name = resession.get_current()
    return session_name or util.get_git_branch()
end

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
                overseer = {}, -- Keep running last task.
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
        vim.keymap.set("n", "<leader>sq", function()
            vim.cmd("qa")
        end, { desc = "Delete session" })

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
                resession.save(get_session_name(), { notify = false })
            end,
        })
    end,
}
