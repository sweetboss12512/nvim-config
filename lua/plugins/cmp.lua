---@diagnostic disable: missing-fields
local icons = require("config.icons")

return {
	"hrsh7th/nvim-cmp",
	-- enabled = false,
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		-- Sources
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-signature-help",
	},
	config = function()
		local cmp = require("cmp")
		local mapping = cmp.mapping
		local select_behavior = cmp.SelectBehavior
		local cmp_insert = {
			-- Documentation scrolling
			["<C-b>"] = mapping.scroll_docs(-4),
			["<C-f>"] = mapping.scroll_docs(4),
			["<C-e>"] = mapping.abort(), -- Cancel autocomplete

			-- Completion
			["<cr>"] = mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			["<Tab>"] = mapping.confirm({ select = true }),

			["<C-n>"] = mapping(function()
				if cmp.visible() then
					cmp.select_next_item({ behavior = select_behavior.Insert })
				else
					cmp.complete()
				end
			end),
			-- Selecting different completions
			["<C-p>"] = mapping(function()
				if cmp.visible() then
					cmp.select_prev_item({ behavior = select_behavior.Insert })
				else
					cmp.complete()
				end
			end),
			["<Down>"] = {
				i = mapping.select_next_item({ behavior = select_behavior.Select }),
			},
			["<Up>"] = {
				i = mapping.select_prev_item({ behavior = select_behavior.select }),
			},
		}

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				-- completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered({ border = "single" }),
			},
			mapping = cmp_insert,
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip", priority = 0 }, -- For luasnip users.
				{ name = "nvim_lsp_signature_help" },
			}, {
				{ name = "buffer" },
			}),

			formatting = {
				format = function(entry, vim_item)
					-- Kind icons
					vim_item.kind = string.format("%s %s", icons.kind[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
					return vim_item
				end,
			},
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp_insert,
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp_insert,
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				-- cmp on WSL can"t handle :!
				vim.fn.has("wsl") == 0 and { name = "cmdline" }
					or {
						name = "cmdline",
						keyword_pattern = [=[[^[:blank:]\!]*]=],
						keyword_length = 3,
					},
			}),
		})
	end,
}
