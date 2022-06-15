function camel_case(str)
	return string.gsub("-" .. str, "(%-)(%l)", function(_, b)
		return string.upper(b)
	end)
end

function get_props_name(_, snip)
	return camel_case(snip.env.TM_FILENAME_BASE) .. "Props"
end

return {
	s(
		"rp",
		fmt(
			[[
    export interface {1} {{
      {2}
    }}
  ]],
			{
				f(get_props_name),
				i(1),
			}
		)
	),
	s("rpn", f(get_props_name)),
}
