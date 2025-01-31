local util = require("util")

local directoryAliases
local fileAliases

local function update_aliases()
	local luau_lsp = require("luau-lsp")
	local vscodeSettings = util.vscode_settings()

	if vscodeSettings then
		directoryAliases = vscodeSettings["luau-lsp.require.directoryAliases"]
		fileAliases = vscodeSettings["luau-lsp.require.fileAliases"]
	else
		directoryAliases = luau_lsp.aliases()
	end
end

return {
	"lopi-py/luau-lsp.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	ft = { "luau" },
	cmd = { "LuauLsp" },
	config = function()
		local luau_lsp = require("luau-lsp")
		update_aliases()
		luau_lsp.setup({
			autostart = true,
			server = {
				filetypes = { "luau" },
				settings = {
					["luau-lsp"] = {
						require = {
							mode = "relativeToFile",
							directoryAliases = directoryAliases,
							fileAliases = fileAliases,
							inlayHints = {
								functionReturnTypes = true,
								parameterTypes = true,
							},
						},
						ignoreGlobs = {
							"**/_Index/**",
						},
						completion = {
							autocompleteEnd = true,
							fillCallArguments = false,
							addParentheses = false,
							imports = {
								enabled = true,
								suggestServices = true,
								suggestRequires = true,
								requireStyle = "alwaysAbsolute",
								ignoreGlobs = {
									"**/_Index/**",
								},
							},
						},
					},
				},
			},
			platform = {
				type = "standard",
			},
			plugin = {
				enabled = false,
				port = 3667,
			},
			sourcemap = {
				enabled = false,
				autogenerate = false,
			},
			types = {
				-- roblox_security_level = "PluginSecurity",
			},
		})
	end,
}
