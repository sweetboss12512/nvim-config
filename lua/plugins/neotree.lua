local icons = require("config.icons")

local TRASH_COMMAND

-- This isn't installed by default!
if vim.fn.has("win32") == 1 then
    TRASH_COMMAND = "recycle-bin.exe"
elseif vim.fn.has("unix") then
    TRASH_COMMAND = "trash"
end

return {
    {

        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = { "Neotree" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "s1n7ax/nvim-window-picker",
        },
        keys = {
            { "\\", "<cmd>Neotree filesystem toggle left<cr>", desc = "Neotree toggle filesystem" },
            { "<leader>\\", "<cmd>Neotree reveal_file=%<cr>", desc = "Neotree find current file" },
        },
        opts = function()
            local utils = require("neo-tree.utils")
            local renderer = require("neo-tree.ui.renderer")
            local fs_scan = require("neo-tree.sources.filesystem.lib.fs_scan")

            local num_started, num_done
            local function scan_all(state, parent_id, callback, rec)
                if not rec then
                    num_started, num_done = 0, 0
                end
                num_started = num_started + 1
                local parent = state.tree.nodes.by_id[parent_id]
                if state.name == "filesystem" and parent.loaded == false then
                    fs_scan.get_items(state, parent_id, nil, function()
                        for _, id in ipairs(parent:get_child_ids()) do
                            if state.tree.nodes.by_id[id].type == "directory" then
                                scan_all(state, id, callback, true)
                            end
                        end
                        num_done = num_done + 1
                        if num_started == num_done then
                            callback()
                        end
                    end)
                else
                    if utils.is_expandable(parent) and not parent:is_expanded() then
                        parent:expand()
                    end
                    for _, id in ipairs(parent:get_child_ids()) do
                        if utils.is_expandable(state.tree.nodes.by_id[id]) then
                            scan_all(state, id, callback, true)
                        end
                    end
                    num_done = num_done + 1
                    if num_started == num_done then
                        callback()
                    end
                end
            end

            vim.g.neo_tree_remove_legacy_commands = 1
            return {
                close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
                popup_border_style = "rounded",
                open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },
                hide_root_node = true,
                -- enable_git_status = false,
                enable_diagnostics = false,

                source_selector = {
                    winbar = true, -- toggle to show selector on winbar
                    statusline = false, -- toggle to show selector on statusline
                    content_layout = "center", -- only with `tabs_layout` = "equal", "focus"
                    separator = "", -- can be string or table, see below
                    sources = { -- table
                        {
                            source = "filesystem", -- string
                            display_name = "󰉓 Files", -- string | nil
                        },
                        -- {
                        -- 	source = "buffers", -- string
                        -- 	display_name = " 󰈚 Buffers ", -- string | nil
                        -- },
                        {
                            source = "git_status", -- string
                            display_name = "󰊢 Git", -- string | nil
                        },
                    },
                },
                default_component_configs = {
                    -- indent = { with_markers = true },
                    icon = {
                        folder_closed = icons.folder.close,
                        folder_open = icons.folder.open,
                        folder_empty = icons.folder.empty,
                        default = icons.file,
                        provider = function(icon, node)
                            local success, mini_icons = pcall(require, "mini.icons")
                            local name = node.type == "terminal" and "terminal" or node.name

                            if not success then
                                return
                            end

                            if node.type == "file" or node.type == "terminal" then
                                local devicon, hl = mini_icons.get("file", name)
                                icon.text = devicon or icon.text
                                icon.highlight = hl or icon.highlight
                            end

                            if node.type == "directory" then
                                local devicon, hl = mini_icons.get("directory", name)
                                icon.text = devicon or icon.text
                                icon.highlight = hl or icon.highlight
                            end
                        end,
                    },
                    git_status = {
                        symbols = {
                            -- Change type
                            added = icons.git.added,
                            modified = "",--[[ icons.git.modified, ]]
                            deleted = icons.git.deleted,
                            renamed = icons.git.renamed,
                            -- Status type,
                            untracked = icons.git.untracked,
                            ignored = icons.git.ignored,
                            unstaged = icons.git.unstaged,
                            staged = icons.git.staged,
                            conflict = icons.git.conflict,
                        },
                    },
                    modified = {
                        symbol = icons.git.modified,
                    },
                    diagnostics = {
                        -- symbols = icons.diagnostics,
                        highlights = {
                            hint = "DiagnosticSignHint",
                            info = "DiagnosticSignInfo",
                            warn = "DiagnosticSignWarn",
                            error = "DiagnosticSignError",
                        },
                    },
                    symlink_target = {
                        enabled = true,
                    },
                },
                window = {
                    -- width = 30,
                    width = 50,
                    auto_expand_width = false,
                    mappings = {
                        ["<esc>"] = function()
                            vim.cmd("nohl")
                        end,
                        ["<tab>"] = function(state)
                            local node = state.tree:get_node()
                            if require("neo-tree.utils").is_expandable(node) then
                                state.commands["toggle_node"](state)
                            else
                                state.commands["open_with_window_picker"](state)
                                vim.cmd("Neotree reveal")
                            end
                        end,
                        -- ["o"] = "open_with_window_picker",
                        ["t"] = "open_tabnew",
                        ["s"] = "split_with_window_picker",
                        ["v"] = "vsplit_with_window_picker",
                        ["C"] = "close_node",
                        ["a"] = {
                            "add",
                            -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                            config = {
                                show_path = "relative", -- "none", "relative", "absolute"
                            },
                        },
                        ["h"] = "",
                        ["l"] = "",
                        ["<2-LeftMouse>"] = "open",

                        ["z"] = "none",
                        ["Z"] = "expand_all_nodes",
                        ["<C-LeftMouse>"] = function(state)
                            local tree = state.tree
                            local node = tree:get_node()

                            if not utils.is_expandable(node) or node:is_expanded() then
                                return
                            end

                            scan_all(state, node:get_id(), function()
                                if tree.cursor_node then
                                    renderer.focus_node(state, tree.cursor_node:get_id())
                                end
                                tree:render()
                            end)
                        end,

                        -- ["zo"] = neotree_zo,
                        -- ["zO"] = neotree_zO,
                        -- ["zc"] = neotree_zc,
                        -- ["zC"] = neotree_zC,
                        -- ["za"] = neotree_za,
                        -- ["zA"] = neotree_zA,
                        -- ["zx"] = neotree_zx,
                        -- ["zX"] = neotree_zX,
                        -- ["zm"] = neotree_zm,
                        -- ["zM"] = neotree_zM,
                        -- ["zr"] = neotree_zr,
                        -- ["zR"] = neotree_zR,
                        -- ["<m-h>"] = "none",
                        -- ["<m-j>"] = "none",
                        -- ["<m-k>"] = "none",
                        -- ["<m-l>"] = "none",
                    },
                },
                filesystem = {
                    hijack_netrw_behavior = "disabled",
                    follow_current_file = {
                        enabled = false,
                    },
                    filtered_items = {
                        visible = true, -- when true, they will just be displayed differently than normal items
                        hide_dotfiles = false,
                        hide_gitignored = false,
                        hide_hidden = true, -- only works on Windows for hidden files/directories
                        never_show = { -- remains hidden even if visible is toggled to true
                            ".DS_Store",
                            "thumbs.db",
                            ".git",
                        },
                    },

                    -- Why isn't this enabled by default? It's BUGGY
                    use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                    -- instead of relying on nvim autocmd events.
                    window = {
                        mappings = {
                            ["i"] = "run_command",
                            ["[c"] = "prev_git_modified",
                            ["]c"] = "next_git_modified",
                            ["<LeftRelease>"] = "toggle_node",
                            ["gA"] = "git_add_all",
                            ["gu"] = "git_unstage_file",
                            -- ["ga"] = "git_add_file",
                            -- ["gr"] = "git_revert_file",
                            -- ["gc"] = "git_commit",
                            -- ["gp"] = "git_push",
                            -- ["gg"] = "git_commit_and_push",
                            ["/"] = "none",
                            ["<leader>ip"] = "image_preview",
                        },
                    },
                    commands = {
                        run_command = function(state)
                            local node = state.tree:get_node()
                            local path = node:get_id()
                            vim.api.nvim_input(": " .. path .. "<Home>")
                        end,
                        image_preview = function(state)
                            local node = state.tree:get_node()
                            if node.type == "file" then
                                require("image_preview").PreviewImage(node.path)
                            end
                        end,

                        delete = function(state)
                            local inputs = require("neo-tree.ui.inputs")
                            local log = require("neo-tree.log")
                            local loop = vim.loop
                            local scan = require("plenary.scandir")

                            local path = state.tree:get_node().path
                            local _, name = utils.split_path(path)
                            local msg = string.format("Are you sure you want to trash '%s'?", name)

                            log.trace("Trashing node: ", path)
                            local _type = "unknown"
                            local stat = loop.fs_stat(path)
                            if stat then
                                _type = stat.type
                                if _type == "link" then
                                    local link_to = loop.fs_readlink(path)
                                    if not link_to then
                                        log.error("Could not read link")
                                        return
                                    end
                                    _type = loop.fs_stat(link_to)
                                end
                                if _type == "directory" then
                                    local children = scan.scan_dir(path, {
                                        hidden = true,
                                        respect_gitignore = false,
                                        add_dirs = true,
                                        depth = 1,
                                    })
                                    if #children > 0 then
                                        msg = "WARNING: Dir not empty! " .. msg
                                    end
                                end
                            else
                                log.warn("Could not read file/dir:", path, stat, ", attempting to delete anyway...")
                                -- Guess the type by whether it appears to have an extension
                                if path:match("%.(.+)$") then
                                    _type = "file"
                                else
                                    _type = "directory"
                                end
                                return
                            end

                            local do_delete = function()
                                local result = vim.fn.system({ TRASH_COMMAND, vim.fn.fnameescape(path) })
                                local error = vim.v.shell_error
                                if error ~= 0 then
                                    log.debug(
                                        string.format(
                                            "Could not trash directory '",
                                            path,
                                            "' with '%s': ",
                                            TRASH_COMMAND
                                        ),
                                        result
                                    )
                                end
                            end

                            inputs.confirm(msg, do_delete)
                        end,
                    },
                },
                buffers = {
                    follow_current_file = {
                        enabled = false, -- This will find and focus the file in the active buffer every time
                        --               -- the current file is changed while the tree is open.
                        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                    },
                    -- time the current file is changed while the tree is open.
                    group_empty_dirs = false, -- when true, empty folders will be grouped together
                    show_unloaded = true,
                    window = {
                        mappings = {
                            ["gA"] = "git_add_all",
                            ["gu"] = "git_unstage_file",
                            ["ga"] = "git_add_file",
                            ["gr"] = "git_revert_file",
                            ["gc"] = "git_commit",
                            ["gp"] = "git_push",
                            ["gg"] = "git_commit_and_push",
                        },
                    },
                },

                git_status = {
                    window = {
                        mappings = {
                            ["A"] = "none",
                            ["gA"] = "git_add_all",
                        },
                    },
                },
                event_handlers = {
                    {
                        event = "neo_tree_popup_input_ready",
                        handler = function()
                            vim.cmd("stopinsert")
                        end,
                    },
                    {
                        event = "neo_tree_popup_input_ready",
                        ---@param args { bufnr: integer, winid: integer }
                        handler = function(args)
                            vim.keymap.set("i", "<esc>", vim.cmd.stopinsert, { noremap = true, buffer = args.bufnr })
                        end,
                    },
                },
            }
        end,
    },
}
