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
            desc = "OverseerRestartLast",
        },
        {
            "<leader>of",
            "<cmd>OverseerRun<cr>",
        },
        {
            "<leader>ot",
            "<cmd>OverseerToggle<cr>",
        },
    },
    opts = {},
    config = function(_, opts)
        require("overseer").setup(opts)
    end,
}
