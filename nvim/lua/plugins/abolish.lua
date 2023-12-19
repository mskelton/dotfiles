return {
	{
		"tpope/vim-abolish",
		cmd = { "Abolish", "Subvert" },
		lazy = false,
		config = function()
			vim.cmd.Abolish("accomodate", "accommodate")
			vim.cmd.Abolish("accross", "across")
			vim.cmd.Abolish("appologize", "apologize")
			vim.cmd.Abolish("calender", "calendar")
			vim.cmd.Abolish("committment", "commitment")
			vim.cmd.Abolish("concious", "conscious")
			vim.cmd.Abolish("deductable", "deductible")
			vim.cmd.Abolish("definately", "definitely")
			vim.cmd.Abolish("embarass{,ment}", "embarrass{,ment}")
			vim.cmd.Abolish("enviroment", "environment")
			vim.cmd.Abolish("existance", "existence")
			vim.cmd.Abolish("grammer", "grammar")
			vim.cmd.Abolish("independant", "independent")
			vim.cmd.Abolish("neccessary", "necessary")
			vim.cmd.Abolish("occassion", "occasion")
			vim.cmd.Abolish("occured", "occurred")
			vim.cmd.Abolish("occurence", "occurrence")
			vim.cmd.Abolish("posession", "possession")
			vim.cmd.Abolish("priviledge", "privilege")
			vim.cmd.Abolish("reciept", "receipt")
			vim.cmd.Abolish("recieve", "receive")
			vim.cmd.Abolish("relevent", "relevant")
			vim.cmd.Abolish("seperate", "separate")
			vim.cmd.Abolish("teh", "the")
			vim.cmd.Abolish("wierd", "weird")
		end,
	},
}
