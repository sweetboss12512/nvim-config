---@diagnostic disable: missing-fields
local icons = require("config.icons")
return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = "rafamadriz/friendly-snippets",

	-- use a release tag to download pre-built binaries
	version = "v0.*",
	pin = true, -- No break unless i want to deal with it pls
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- see the "default configuration" section below for full documentation on how to define
		-- your own keymap.
		keymap = { preset = "enter" },
		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- will be removed in a future release
			use_nvim_cmp_as_default = false,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
			kind_icons = {
				-- 	Class = "󱡠",
				-- 	Color = "󰏘",
				-- 	Constant = "󰏿",
				-- 	Constructor = "󰒓",
				-- 	Enum = "󰦨",
				-- 	EnumMember = "󰦨",
				-- 	Event = "󱐋",
				-- 	Field = "󰜢",
				-- 	File = "󰈔",
				-- 	Folder = "󰉋",
				-- 	Function = "󰊕",
				-- 	Interface = "󱡠",
				-- 	Keyword = "󰻾",
				-- 	Method = "󰊕",
				-- 	Module = "󰅩",
				-- 	Operator = "󰪚",
				-- 	Property = "󰖷",
				-- 	Reference = "󰬲",
				-- 	Snippet = "󱄽",
				-- 	Struct = "󱡠",
				-- 	Text = "󰉿",
				-- 	TypeParameter = "󰬛",
				-- 	Unit = "󰪚",
				-- 	Value = "󰦨",
				-- 	Variable = "󰆦",
				Class = icons.kind.Class,
				Color = icons.kind.Color,
				Constant = icons.kind.Constant,
				Constructor = icons.kind.Constructor,
				Enum = icons.kind.Enum,
				EnumMember = icons.kind.EnumMember,
				Event = icons.kind.Event,
				Field = icons.kind.Field,
				File = icons.kind.File,
				Folder = icons.kind.Folder,
				Function = icons.kind.Function,
				Interface = icons.kind.Interface,
				Keyword = icons.kind.Keyword,
				Method = icons.kind.Method,
				Module = icons.kind.Module,
				Operator = icons.kind.Operator,
				Property = icons.kind.Property,
				Reference = icons.kind.Reference,
				Snippet = icons.kind.Snippet,
				Struct = icons.kind.Struct,
				Text = icons.kind.Text,
				TypeParameter = icons.kind.TypeParameter,
				Unit = icons.kind.Unit,
				Value = icons.kind.Value,
				Variable = icons.kind.Variable,
			},
		},

		-- default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, via `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			-- optionally disable cmdline completions
			-- cmdline = {},
		},
		completion = {
			menu = {
				border = "none",
				draw = {
					columns = { { "kind_icon" }, { "label", "kind", "label_description", gap = 1 } },
				},
			},
			documentation = {
				-- Controls whether the documentation window will automatically show when selecting a completion item
				auto_show = true,
				-- Delay before showing the documentation window
				-- auto_show_delay_ms = 500,
				auto_show_delay_ms = 0,
				-- Delay before updating the documentation window when selecting a new item,
				-- while an existing item is still visible
				update_delay_ms = 50,
				-- Whether to use treesitter highlighting, disable if you run into performance issues
				treesitter_highlighting = true,
				window = {
					min_width = 10,
					max_width = 60,
					max_height = 20,
					border = "single",
					winblend = 0,
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
				},
			},
		},
		-- experimental signature help support
		signature = {
			enabled = true,
			window = {
				border = "single",
			},
		},
	},
	-- allows extending the providers array elsewhere in your config
	-- without having to redefine it
	opts_extend = { "sources.default" },
}
