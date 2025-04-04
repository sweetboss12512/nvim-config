-- These keybinds are a little horrid.
return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
        local mc = require("multicursor-nvim")

        mc.setup()

        vim.keymap.set({ "n", "x" }, "<up>", function()
            mc.lineAddCursor(-1)
        end)
        vim.keymap.set({ "n", "x" }, "<down>", function()
            mc.lineAddCursor(1)
        end)

        vim.keymap.set({ "n", "x" }, "ga", mc.addCursorOperator, { desc = "Add cursor operator (Multicursor)" })

        -- Add or skip adding a new cursor by matching word/selection
        vim.keymap.set({ "n", "x" }, "<leader>mn", function()
            mc.matchAddCursor(1)
        end, { desc = "Match Add Cursor (Multicursor)" })
        -- vim.keymap.set({ "n", "x" }, "<leader>s", function()
        --     mc.matchSkipCursor(1)
        -- end, { desc = "Match Skip Cursor (Multicursor)" })
        vim.keymap.set({ "n", "x" }, "<leader>mN", function()
            mc.matchAddCursor(-1)
        end)
        vim.keymap.set({ "n", "x" }, "<leader>S", function()
            mc.matchSkipCursor(-1)
        end)

        -- Press `mWi"ap` will create a cursor in every match of string captured by `i"` inside range `ap`.
        vim.keymap.set("n", "gm", mc.operator, { desc = "Multicursor Operator" })

        -- Add all matches in the document
        -- stylua: ignore
        vim.keymap.set({ "n", "x" }, "<leader>mA", mc.matchAllAddCursors, { desc = "Add all search :wmatches in the document (Multicursor)" })

        -- Add and remove cursors with control + left click.
        vim.keymap.set("n", "<M-leftmouse>", mc.handleMouse)
        vim.keymap.set("n", "<M-leftdrag>", mc.handleMouseDrag)
        vim.keymap.set("n", "<M-leftrelease>", mc.handleMouseRelease)

        -- Easy way to add and remove cursors using the main cursor.
        vim.keymap.set({ "n", "x" }, "<c-q>", mc.toggleCursor)

        -- Clone every cursor and disable the originals.
        vim.keymap.set({ "n", "x" }, "<leader>md", mc.duplicateCursors, { desc = "Duplicate Cursors (Mulitcursor)" })

        -- vim.keymap.set({ "n", "x" }, "g<c-a>", mc.sequenceIncrement)
        -- vim.keymap.set({ "n", "x" }, "g<c-x>", mc.sequenceDecrement)

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)
            -- Select a different cursor as the main one.
            layerSet({ "n", "x" }, "<left>", mc.prevCursor)
            layerSet({ "n", "x" }, "<right>", mc.nextCursor)

            -- Delete the main cursor.
            layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor, { desc = "Delete main cursor (Multicursor)" })

            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

        -- bring back cursors if you accidentally clear them
        vim.keymap.set("n", "<leader>mr", mc.restoreCursors, { desc = "Restore Cursors (Mulitcursor)" })

        -- Align cursor columns.
        vim.keymap.set("n", "<leader>m=", mc.alignCursors, { desc = "Align cursor columns (Mulitcursor)" })

        -- Split visual selections by regex. 'S' is taken by surround :/
        vim.keymap.set("x", "ms", mc.splitCursors, { desc = "Split cursors by regex (Mulitcursor)" })

        -- Append/insert for each line of visual selections.
        vim.keymap.set("x", "I", mc.insertVisual)
        vim.keymap.set("x", "A", mc.appendVisual)

        -- match new cursors within visual selections by regex.
        vim.keymap.set("x", "M", mc.matchCursors)

        -- Rotate visual selection contents.
        vim.keymap.set("x", "<leader>mt", function()
            mc.transposeCursors(1)
        end, { desc = "Transpose Cursors (Mulitcursor)" })
        vim.keymap.set("x", "<leader>mT", function()
            mc.transposeCursors(-1)
        end, { desc = "Transpose Cursors Backward (Mulitcursor)" })

        -- Jumplist support
        vim.keymap.set({ "x", "n" }, "<c-i>", mc.jumpForward)
        vim.keymap.set({ "x", "n" }, "<c-o>", mc.jumpBackward)
    end,
}
