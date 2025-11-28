-- These keybinds are a little horrid.
return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = "VeryLazy",
    config = function()
        local mc = require("multicursor-nvim")

        mc.setup()

        -- stylua: ignore start
        vim.keymap.set({ "n", "x" }, "<c-k>", function() mc.lineAddCursor(-1) end)
        vim.keymap.set({ "n", "x" }, "<c-j>", function() mc.lineAddCursor(1) end)
        -- stylua: ignore end

        vim.keymap.set({ "n", "x" }, "ga", mc.addCursorOperator, { desc = "Add cursor operator (Multicursor)" })

        -- Press `mWi"ap` will create a cursor in every match of string captured by `i"` inside range `ap`.
        vim.keymap.set("n", "gm", mc.operator, { desc = "Multicursor Operator" })

        -- Add all matches in the document
        -- stylua: ignore
        vim.keymap.set({ "n", "x" }, "<leader>mA", mc.matchAllAddCursors, { desc = "Add all search :wmatches in the document (Multicursor)" })

        -- Add and remove cursors with control + left click.
        vim.keymap.set("n", "<C-leftmouse>", mc.handleMouse)
        vim.keymap.set("n", "<C-leftdrag>", mc.handleMouseDrag)
        vim.keymap.set("n", "<C-leftrelease>", mc.handleMouseRelease)

        -- Easy way to add and remove cursors using the main cursor.
        vim.keymap.set({ "n", "x" }, "<c-q>", mc.toggleCursor)

        -- Clone every cursor and disable the originals.
        vim.keymap.set({ "n", "x" }, "<leader>md", mc.duplicateCursors, { desc = "Duplicate Cursors (Mulitcursor)" })

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)
            -- Select a different cursor as the main one. Helix like
            layerSet({ "n", "x" }, "(", mc.prevCursor)
            layerSet({ "n", "x" }, ")", mc.nextCursor)
            -- stylua: ignore start
            layerSet({ "n", "x" }, "<M-(>", function() mc.transposeCursors(-1) end) -- This kinda sucks. But barely used.
            layerSet({ "n", "x" }, "<M-)>", function() mc.transposeCursors(1) end)
            -- stylua: ignore end

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

            -- Jumplist support
            layerSet({ "x", "n" }, "<c-i>", mc.jumpForward)
            layerSet({ "x", "n" }, "<c-o>", mc.jumpBackward)

            layerSet({ "n", "x" }, "g<c-a>", mc.sequenceIncrement)
            layerSet({ "n", "x" }, "g<c-x>", mc.sequenceDecrement)
        end)

        -- bring back cursors if you accidentally clear them
        vim.keymap.set("n", "<leader>mr", mc.restoreCursors, { desc = "Restore Cursors (Mulitcursor)" })
        vim.keymap.set("n", "<leader>m=", mc.alignCursors, { desc = "Align cursor columns (Mulitcursor)" })
        -- Split visual selections by regex. 'S' is taken by surround :/
        vim.keymap.set("x", "<M-s>", mc.splitCursors, { desc = "Split cursors by regex (Mulitcursor)" })
        -- Append/insert for each line of visual selections.
        vim.keymap.set("x", "I", mc.insertVisual)
        vim.keymap.set("x", "A", mc.appendVisual)
        -- match new cursors within visual selections by regex.
        vim.keymap.set("x", "s", mc.matchCursors)
    end,
}
