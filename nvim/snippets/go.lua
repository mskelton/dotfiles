---@diagnostic disable: undefined-global

return {
	parse("cl", 'fmt.Println("$1")$0'),
	parse("eif", "if err != nil {\n\treturn err\n}$0"),
}
