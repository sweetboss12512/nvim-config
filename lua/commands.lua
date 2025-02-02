vim.api.nvim_create_user_command("Config", function()
    if not vim.g.vscode then
        vim.cmd(":tabedit $MYVIMRC | :tcd %:p:h | edit .")
    else
        vim.fn.jobstart(string.format("code %s", vim.fn.stdpath("config")))
    end
end, {})

vim.api.nvim_create_user_command("BdOthers", function()
    local current_bufnr = vim.api.nvim_get_current_buf()
    local bufnr_list = vim.api.nvim_list_bufs()

    for _, bufnr in ipairs(bufnr_list) do
        if bufnr ~= current_bufnr then
            vim.api.nvim_buf_delete(bufnr, {})
        end
    end
end, {})

vim.api.nvim_create_user_command("HoverPin", function()
    local contents = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    vim.cmd("vnew")
    local bufnr = vim.api.nvim_get_current_buf()

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, contents)
    vim.bo[bufnr].modifiable = false
    vim.bo[bufnr].buftype = "nofile"
    vim.bo[bufnr].filetype = "markdown"
end, {})

-- This is only an issue on windows.
if vim.fn.has("win32") == 1 then
    vim.api.nvim_create_user_command("ShadaClean", function()
        local files = vim.split(vim.fn.glob(vim.fn.stdpath("data") .. "/shada/*"), "\n", { trimempty = true }) -- screw vim.fs.joinpath

        for _, v in ipairs(files) do
            os.remove(v)
        end

        vim.notify("Deleted all shada files")
    end, {})
end

-- vim.api.nvim_create_user_command("Lune", function(info)
-- 	vim.print(vim.inspect(info))
-- 	-- local cmd_file =
--
-- 	-- vim.fn.jobstart(string.format("lune run %s", vim.fn.stdpath("config")))
-- end, { nargs = "*" })
