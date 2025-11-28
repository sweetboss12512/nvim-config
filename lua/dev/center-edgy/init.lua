local edgy = require("edgy")

local function update()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.bo[buf].filetype

        local info = edgy.get_win(win)

        if not info then
            -- print("No data for window")
            return
        end

        -- print(info.view.edgebar.pos, ft)

        -- if ft and not vim.b[buf].edgy_disable and not vim.w[win].edgy_disable then
        -- end

        local width = vim.api.nvim_get_option_value("columns", { scope = "global" })
        print(width)
    end
end

vim.api.nvim_create_autocmd({ "WinEnter" }, {
    group = vim.api.nvim_create_augroup("center-edgy", { clear = true }),
    callback = function()
        vim.schedule(update) -- Solves race condition between edgy
    end,
})
