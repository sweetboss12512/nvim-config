local renderMarkdown = {
    "MeanderingProgrammer/render-markdown.nvim",
    -- enabled = false,
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
    event = "BufEnter",
    opts = {
        enable = true,
    },
}

-- local function extend_hl(name, def)
-- 	local current_def = vim.api.nvim_get_hl(0, { name = name })
-- 	local new_def = vim.tbl_extend("force", {}, current_def, def)
--
-- 	vim.api.nvim_set_hl(0, name, new_def)
-- 	return name
-- end

local markview = {
    "OXY2DEV/markview.nvim",
    priority = 500000,
    lazy = false,
    config = function()
        local presets = require("markview.presets")
        require("markview").setup({
            markdown = {},
        })
    end,
}

-- markdownH1     xxx cterm=bold gui=bold guifg=#c4a7e7
return {
    renderMarkdown,
    -- markview,
}
