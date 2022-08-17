vim.api.nvim_create_user_command("Gradle", "!./gradlew <args>", { nargs = "+" })
vim.api.nvim_create_user_command("Hub", "!gh <args>", { nargs = "+" })
vim.api.nvim_create_user_command("Pomo", "!pomo <args>", { nargs = "*" })
vim.api.nvim_create_user_command("Task", "!task <args>", { nargs = "*" })

-- Yarn
vim.api.nvim_create_user_command("Yarn", "!yarn <args>", { nargs = "*" })
vim.api.nvim_create_user_command("Y", "!yarn <args>", { nargs = "*" })

-- Help in current window
vim.cmd([[
  let s:did_open_help = v:false
	function s:HelpCurwin(subject) abort
	  let mods = 'silent noautocmd keepalt'

	  if !s:did_open_help
	    execute mods .. ' help'
	    execute mods .. ' helpclose'
	    let s:did_open_help = v:true
	  endif

	  if !empty(getcompletion(a:subject, 'help'))
	    execute mods .. ' edit ' .. &helpfile
	    set buftype=help
	  endif

	  return 'help ' .. a:subject
	endfunction

	command -bar -nargs=? -complete=help Help execute s:HelpCurwin(<q-args>)
]])
