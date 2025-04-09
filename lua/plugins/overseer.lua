return {
    "stevearc/overseer.nvim",
    -- enabled = false,
    lazy = false,
    keys = {
        {
            "<leader>or",
            function()
                local overseer = require("overseer")
                local tasks = overseer.list_tasks({ recent_first = true })
                if vim.tbl_isempty(tasks) then
                    vim.notify("No tasks found", vim.log.levels.WARN)
                else
                    overseer.run_action(tasks[1], "restart")
                end
            end,
            desc = "Restart Last Task",
        },
        { "<leader>ow", "<cmd>OverseerToggle<cr>", desc = "Task list" },
        { "<leader>oo", "<cmd>OverseerRun<cr>", desc = "Run task" },
        { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
        { "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
        { "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Task builder" },
        { "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
        { "<leader>oc", "<cmd>OverseerClearCache<cr>", desc = "Clear cache" },
    },
    opts = {},
}
