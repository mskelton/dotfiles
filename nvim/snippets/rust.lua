--- @diagnostic disable: undefined-global

local test = [[
#[test]
fn $1() {
    $0
}
]]

return {
	parse("cl", 'println!("{:?}", $0);'),
	parse("fn", "fn $1($2) {\n\t$0\n}"),
	parse("tit", test),
}
