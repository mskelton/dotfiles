---@diagnostic disable: undefined-global

return {
	parse("cl", 'fmt.Println("$1")$0'),
	parse("fn", "func $1($2) {\n\t$0\n}"),
	parse("ife", "if err != nil {\n\treturn err\n}$0"),
}
