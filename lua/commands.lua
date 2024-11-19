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

-- vim.api.nvim_create_user_command("Lune", function(info)
-- 	vim.print(vim.inspect(info))
-- 	-- local cmd_file =
--
-- 	-- vim.fn.jobstart(string.format("lune run %s", vim.fn.stdpath("config")))
-- end, { nargs = "*" })
