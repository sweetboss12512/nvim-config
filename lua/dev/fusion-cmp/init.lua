local cmp_types = require("cmp.types")
local ts_utils = require("nvim-treesitter.ts_utils")
local source = {}

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
local properties_cache = {}

---@param items any
---@param context cmp.Context
local function transform(items, context)
	return vim.tbl_map(function(entry)
		return vim.tbl_deep_extend("force", entry, {
			-- kind = require("blink.cmp.types").CompletionItemKind.Text,
			textEdit = {
				range = {
					start = { line = context.cursor.col - 1, character = context.bounds.start_col - 2 },
					["end"] = { line = context.cursor.col - 1, character = context.row },
				},
			},
		})
	end, items)
end

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
		kind = cmp_types.lsp.CompletionItemKind.Class,
	})
	table.insert(instance_names, object.Name)
	properties_cache[object.Name] = {}

	for _, data in ipairs(object.Members) do
		if data.MemberType == "Property" then
			table.insert(properties_cache[object.Name], {
				label = data.Name,
				kind = cmp_types.lsp.CompletionItemKind.Property,
				insertText = ("%s = "):format(data.Name),
			})
		end
	end
end

---@param params cmp.SourceCompletionApiParams
---@param callback fun(response: lsp.CompletionResponse)
function source:complete(params, callback)
	-- if not is_in_new() then
	-- 	return
	-- end

	local completions
	local class_name = get_class_name()

	if class_name then
		completions = properties_cache[class_name]
	elseif is_in_new() then
		completions = instance_names
	end

	callback(completions or {})
end

require("cmp").register_source("fusion", source)

return source
