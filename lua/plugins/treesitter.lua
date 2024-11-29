local treesitterMain = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"RRethy/nvim-treesitter-endwise", -- For ending very nicely
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
		{
			"kiyoon/treesitter-indent-object.nvim",
			keys = {
				{
					"ai",
					function()
						require("treesitter_indent_object.textobj").select_indent_outer()
					end,
					mode = { "x", "o" },
					desc = "Select context-aware indent (outer)",
				},
				{
					"aI",
					function()
						require("treesitter_indent_object.textobj").select_indent_outer(true)
					end,
					mode = { "x", "o" },
					desc = "Select context-aware indent (outer, line-wise)",
				},
				{
					"ii",
					function()
						require("treesitter_indent_object.textobj").select_indent_inner()
					end,
					mode = { "x", "o" },
					desc = "Select context-aware indent (inner, partial range)",
				},
				{
					"iI",
					function()
						require("treesitter_indent_object.textobj").select_indent_inner(true, "V")
					end,
					mode = { "x", "o" },
					desc = "Select context-aware indent (inner, entire range) in line-wise visual mode",
				},
			},
		},
	},
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			-- A list of parser names, or "all" (the five listed parsers should always be installed)
			ensure_installed = { "lua", "luau", "vim", "vimdoc", "query" },

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			-- List of parsers to ignore installing (or "all")
			ignore_install = {},

			highlight = {
				enable = not vim.g.vscode,
				-- max_file_lines = 10000,
				-- disable = function(lang, bufnr)
				-- 	return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 1048576
				-- end,

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},

			endwise = {
				enable = not vim.g.vscode,
			},

			textobjects = {
				select = {
					enable = true,

					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,

					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						["ac"] = "@class.outer",
						["uc"] = "@comment.outer",
						-- You can optionally set descriptions to the mappings (used in the desc parameter of
						-- nvim_buf_set_keymap) which plugins like which-key display
						-- You can also use captures from other query groups like `locals.scm`
						["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
					},
					-- If you set this to `true` (default is `false`) then any textobject is
					-- extended to include preceding or succeeding whitespace. Succeeding
					-- whitespace has priority in order to act similarly to eg the built-in
					-- `ap`.
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * selection_mode: eg 'v'
					-- and should return true or false
					include_surrounding_whitespace = true,
				},
			},
		})

		---@diagnostic disable-next-line: missing-fields
		require("nvim-ts-autotag").setup({
			opts = {
				-- Defaults
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false, -- Auto close on trailing </
			},
			-- Also override individual filetype configs, these take priority.
			-- Empty by default, useful if one of the "opts" global settings
			-- doesn't work well in a specific filetype
			per_filetype = {
				["html"] = {
					enable_close = true,
				},
			},
		})
	end,
}

return {
	treesitterMain,
	{
		"Wansmer/treesj",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
		config = function()
			local tsj = require("treesj")
			local tsj_utils = require("treesj.langs.utils")
			local lua = require("treesj.langs.lua")

			tsj.setup({
				use_default_keymaps = false,
				max_join_length = 1000,
				langs = {
					luau = tsj_utils.merge_preset(lua, {
						object_type = tsj_utils.set_preset_for_dict(),
					}),
				},
			})

			vim.keymap.set(
				"n",
				"<leader>m",
				require("treesj").toggle,
				{ desc = " Split or Join code block with autodetect" }
			)
		end,
	},
}
