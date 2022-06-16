return {
	s(
		"pw-collection",
		fmt(
			[[
        {}{}class {} extends Collection {{
          {}{}
        }}
      ]],
			{
				c(1, {
					t({ "import Collection from 'lariat'", "", "" }),
					t(""),
				}),
				c(2, { t("export "), t("") }),
				i(3, "MyCollection"),
				c(4, {
					sn(nil, {
						i(1),
						t({ "constructor (page: Page) {", "\t\t" }),
						i(2),
						t({ "\t}", "", "\t" }),
					}),
					t(""),
				}),
				i(0),
			}
		)
	),
}
