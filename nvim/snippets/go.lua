--- @diagnostic disable: undefined-global

local function is_pointer(text)
	return string.find(text, "*", 1, true) ~= nil
end

local function is_struct(text)
	return not string.find(text, "*", 1, true)
		and string.upper(string.sub(text, 1, 1)) == string.sub(text, 1, 1)
end

local default_values = {
	int = "0",
	bool = "false",
	string = '""',
	error = function(_, info)
		if info then
			return t(info.err_name or "err")
		else
			return t("err")
		end
	end,
	--- Types with a '*' are pointers, so return nil
	[is_pointer] = function(_, _)
		return t("nil")
	end,
	--- If not a pointer and it's a capital letter, it's a struct
	[is_struct] = function(text, _)
		return t(text .. "{}")
	end,
}

--- Transforms some text into a snippet node
--- @param text string
--- @param info table
local function transform(text, info)
	--- Determines whether the key matches the condition
	local function condition_matches(condition, ...)
		if type(condition) == "string" then
			return condition == text
		else
			return condition(...)
		end
	end

	--- Find the matching condition to get the correct default value
	for condition, result in pairs(default_values) do
		if condition_matches(condition, text, info) then
			if type(result) == "string" then
				return t(result)
			else
				return result(text, info)
			end
		end
	end

	--- If no matches are found, just return the text
	return t(text)
end

local handlers = {
	--- (a, b, c)
	parameter_list = function(node, info)
		local result = {}

		local count = node:named_child_count()
		for idx = 0, count - 1 do
			local matching_node = node:named_child(idx)
			local type_node = matching_node:field("type")[1]
			table.insert(
				result,
				transform(vim.treesitter.get_node_text(type_node, 0), info)
			)

			if idx ~= count - 1 then
				table.insert(result, t(", "))
			end
		end

		return result
	end,

	--- bool
	type_identifier = function(node, info)
		local text = vim.treesitter.get_node_text(node, 0)
		return { transform(text, info) }
	end,
}

--- Gets the corresponding result type based on the current function context
--- @param info table
local function go_result_type(info)
	local function_node_types = {
		function_declaration = true,
		method_declaration = true,
		func_literal = true,
	}

	--- Find the first function node that's a parent of the cursor
	local node = vim.treesitter.get_node()
	while node ~= nil do
		if function_node_types[node:type()] then
			break
		end

		node = node:parent()
	end

	--- If we didn't find a function node, return an empty string
	if not node then
		vim.notify("Not inside of a function")
		return t("")
	end

	local query =
		assert(vim.treesitter.query.get("go", "return-snippet"), "No query")

	for _, capture in query:iter_captures(node, 0) do
		if handlers[capture:type()] then
			return handlers[capture:type()](capture, info)
		end
	end

	--- This shouldn't ever happen, but just in case
	return t("")
end

local function go_return_values(args)
	return sn(
		nil,
		go_result_type({
			index = 0,
			err_name = args[1][1],
			func_name = args[2][1],
		})
	)
end

return {
	parse(":", "$1 := $0"),
	parse("cl", 'fmt.Println("$1")$0'),
	parse("sp", 'fmt.Sprintf("${1:%s}", ${2:args})$0'),
	parse("fn", "func $1($2) {\n\t$0\n}"),
	parse("anon", "${1:fn} := func() {\n\t$0\n}"),
	parse("ap", "append(${1:slice}, ${2:value})$0"),
	parse("ap=", "${1:slice} = append($1, ${2:value})$0"),
	parse("iota", "const (\n\t$1 = iota\n\t$0\n)"),
	parse("ife", "if err := ${1:condition}; err != nil {\n\t$0\n}"),
	parse("ie", "if err != nil {\n\treturn ${1:err}\n}$0"),
	parse("for", "for ${1:_}, ${2:v} := range ${3:iter} {\n\t$0\n}"),
	parse("struct", "type ${1:Type} struct {\n\t$0\n}"),
	parse("test", "func Test${1:Name}(t *testing.T) {\n\t$0\n}"),
	s(
		"meth",
		fmta(
			[[
        func (<receiver> *<type>) <name>(<params>) {
          <finish>
        }
      ]],
			{
				receiver = i(1, "t"),
				type = i(2, "Type"),
				name = i(3, "Name"),
				params = i(4),
				finish = i(0),
			}
		)
	),
	--- Borrowed from TJ's config, thanks!
	--- https://github.com/tjdevries/config_manager/blob/eb8c846/xdg_config/nvim/lua/tj/snips/ft/go.lua
	s(
		"ef",
		fmta(
			[[
        <val>, <err> := <f>(<args>)
        if <err_same> != nil {
          return <result>
        }
        <finish>
      ]],
			{
				val = i(1),
				err = i(2, "err"),
				f = i(3),
				args = i(4),
				err_same = rep(2),
				result = d(5, go_return_values, { 2, 3 }),
				finish = i(0),
			}
		)
	),
}
