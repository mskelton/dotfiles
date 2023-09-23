--- @diagnostic disable: undefined-global

return {
	parse("cl", 'println!("{:?}", $0);'),
	parse("fn", "fn $1($2) {\n\t$0\n}"),
}
