local async = require("blink.cmp.lib.async")
local ts_utils = require("nvim-treesitter.ts_utils")
local config

local completions = {
    CFrame = "CFrame.new(%s)",
    Color3 = "Color3.new(%s)",
    ColorSequence = "ColorSequence.new(%s)",
    ColorSequenceKeypoint = "ColorSequenceKeypoint.new(%s)",
    NumberRange = "NumberRange.new(%s)",
    NumberSequence = "NumberSequence.new(%s)",
    NumberSequenceKeypoint = "NumberSequenceKeypoint.new(%s)",
    PhysicalProperties = "PhysicalProperties.new(%s)",
    Ray = "Ray.new(%s)",
    Rect = "Rect.new(%s)",
    Region3 = "Region3.new(%s)",
    Region3int16 = "Region3int16.new(%s)",
    UDim = "UDim.new(%s)",
    UDim2 = "UDim2.new(%s)",
    Vector2 = "Vector2.new(%s)",
    Vector2int16 = "Vector2int16.new(%s)",
    Vector3 = "Vector3.new(%s)",
    Vector3int16 = "Vector3int16.new(%s)",
}

-- local filePath = "lua/dev/fusion-cmp/API-Dump.json"
local filePath = "C:/Users/sweet/AppData/Local/nvim/lua/dev/fusion-cmp/API-Dump.json"

---@return table
local function get_api_json()
    local fd = assert(vim.uv.fs_open(filePath, "r", 420)) -- 0644
    local stat = assert(vim.uv.fs_fstat(fd))
    local content = vim.uv.fs_read(fd, stat.size)
    vim.uv.fs_close(fd)

    ---@cast content string
    return vim.json.decode(content, { luanil = { object = true } })
end

---@return string?
local function get_class_name()
    local node = ts_utils.get_node_at_cursor(0)

    if not node then
        return
    end

    while node:type() ~= "function_call" do
        -- handling the edge cases like `doctype` node
        if node:parent() == nil then
            --	vim.print("FAILED TO GET NODE")
            return
        end

        node = node:parent()

        if not node then
            return
        end
    end

    local child = node:field("name")[1]:field("arguments")[1]:child(0)

    if not child then
        vim.notify("NO CHILD")
        return
    end

    local fixed = vim.treesitter.get_node_text(child, 0):gsub('"', "")
    return fixed
end

---@return boolean
local function is_in_new()
    local node = ts_utils.get_node_at_cursor(0)

    if not node then
        return false
    end

    if node:type() ~= "string_content" and node:type() ~= "string" then
        --vim.print("NOT IN STRING", node:type())
        return false
    end

    ---@diagnostic disable-next-line: need-check-nil
    while node:type() ~= "function_call" do
        -- handling the edge cases like `doctype` node
        if node:parent() == nil then
            -- print("NODE NOT FOUND")
            return false
        end

        node = node:parent()
    end

    ---@diagnostic disable-next-line: need-check-nil
    local child = node:field("name")[1]

    if not child then
        -- vim.notify("NO CHILD")
        return false
    end

    local methodNode = child:field("method")[1]

    if not methodNode then
        -- vim.notify("NO METHoD")
        return false
    end

    -- vim.notify(vim.inspect(vim.treesitter.get_node_text(child, bufnr)))
    return vim.treesitter.get_node_text(methodNode, 0) == "New"
    -- or vim.treesitter.get_node_text(methodNode, 0) == "CreateElement"
end

local api_json = get_api_json()
local instance_names = {}
local propertiesCache = {}

for _, object in ipairs(api_json.Classes) do
    -- if object.Superclass == "GuiButton" or object.Superclass == "GuiObject" then
    -- 	table.insert(class_names, {
    -- 		label = object.Name,
    -- 		insertText = object.Name,
    -- 		textEdit = { newText = object.Name },
    -- 	})
    -- end

    table.insert(instance_names, {
        label = object.Name,
        insertText = object.Name,
        textEdit = { newText = object.Name },
    })
    propertiesCache[object.Name] = {}

    for _, data in ipairs(object.Members) do
        if data.MemberType == "Property" then
            table.insert(propertiesCache[object.Name], {
                label = data.Name,
                kind = require("blink.cmp.types").CompletionItemKind.Property,
                insertText = ("%s = ,"):format(data.Name),
                textEdit = { newText = object.Name },
            })
        end
    end
end

-- vim.api.nvim_create_user_command("TEST", function()
-- 	local class_name = get_class_name()
-- 	local class_name = "TextButton"
-- 	vim.notify(vim.inspect(propertiesCache[class_name]))
-- end, {})

---Include the trigger character when accepting a completion.
---@param context blink.cmp.Context
local function transform(items, context)
    return vim.tbl_map(function(entry)
        return vim.tbl_deep_extend("keep", entry, {
            kind = require("blink.cmp.types").CompletionItemKind.Class,
            textEdit = {
                range = {
                    start = { line = context.cursor[1] - 1, character = context.bounds.start_col - 1 },
                    ["end"] = { line = context.cursor[1] - 1, character = context.cursor[2] - 1 },
                },
            },
        })
    end, items)
end

---@type blink.cmp.Source
local fusion_source = {}

function fusion_source.new(opts)
    local self = setmetatable({}, { __index = fusion_source })
    config = vim.tbl_deep_extend("keep", opts or {}, {
        insert = false,
    })
    return self
end

---@param context blink.cmp.Context
function fusion_source:get_completions(context, callback)
    -- local task = async.task.empty():map(function()
    -- 	-- local filetype = vim.api.nvim_get_option_value("ft", {})
    -- 	-- local is_char_trigger = vim.list_contains(
    -- 	-- 	self:get_trigger_characters(),
    -- 	-- 	context.line:sub(context.bounds.start_col - 1, context.bounds.start_col - 1)
    -- 	-- )
    -- 	-- local class_name = get_class_name()
    -- 	-- local properties = propertiesCache[class_name] or vim.print("Failed to get properties")
    --
    -- 	---@diagnostic disable-next-line: redefined-local
    -- 	local completions
    -- 	local class_name = get_class_name()
    --
    -- 	if class_name then
    -- 		completions = class_name
    -- 	elseif is_in_new() then
    -- 		completions = instance_names
    -- 	end
    --
    -- 	callback({
    -- 		is_incomplete_forward = true,
    -- 		is_incomplete_backward = true,
    -- 		-- items = is_char_trigger and transform(emojis, context) or {},
    -- 		items = completions and transform(completions, context) or {},
    -- 		-- items = is_in_new() and transform(properties, context) or {},
    -- 		context = context,
    -- 	})
    -- end)

    -- local filetype = vim.api.nvim_get_option_value("ft", {})
    -- local is_char_trigger = vim.list_contains(
    -- 	self:get_trigger_characters(),
    -- 	context.line:sub(context.bounds.start_col - 1, context.bounds.start_col - 1)
    -- )
    -- local class_name = get_class_name()
    -- local properties = propertiesCache[class_name] or vim.print("Failed to get properties")

    ---@diagnostic disable-next-line: redefined-local
    local completions
    -- local class_name = get_class_name()

    -- if class_name then
    -- 	completions = class_name
    -- elseif is_in_new() then
    -- 	completions = instance_names
    -- end
    completions = propertiesCache.TextButton

    callback({
        is_incomplete_forward = true,
        is_incomplete_backward = true,
        -- items = is_char_trigger and transform(emojis, context) or {},
        items = completions and transform(completions, context) or {},
        -- items = is_in_new() and transform(properties, context) or {},
        context = context,
    })

    return function()
        -- task:cancel()
    end
end

---`newText` is used for `ghost_text`, thus it is set to the emoji name in `emojis`.
---Change `newText` to the actual emoji when accepting a completion.
function fusion_source:resolve(item, callback)
    local resolved = vim.deepcopy(item)
    if config.insert then
        resolved.textEdit.newText = resolved.insertText
    end
    return callback(resolved)
end

return fusion_source
