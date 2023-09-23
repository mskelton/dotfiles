--- @diagnostic disable: undefined-global

return {
	parse("cl", 'let () = Printf.printf "%$1\\n" $0'),
}
