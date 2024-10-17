vim.api.nvim_create_user_command("Config", function()
	vim.cmd(":tabedit $MYVIMRC/..")
end, {})
