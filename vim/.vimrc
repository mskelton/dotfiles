" Space is a much better leader key.
let mapleader = " "
let maplocalleader = " "

" I've debated a lot about the clipboard. Accessing my system clipboard for
" pasting is something I do all the time, so it does feel right to
set clipboard=unnamedplus

" Setting the color column to 81 feels wrong, but text can advanced up to and
" including the 80th column. Only when it hits column 81 (now overlapping the
" color column), should it be shown as an issue.
set colorcolumn=81

" Use a vertical bar cursor in the command line window
set guicursor+=c:ver25

" Show trailing spaces
set list
set listchars=tab:\ \ ,trail:·

" Better split directions
set splitright
set splitbelow

" Spell checking
set spelllang=en_us
if has('nvim')
  set spelloptions=camel,noplainbuffer
endif

" I don't use the mouse often, in fact when I do it's often wrong. But
" sometimes when you are in a meeting leaning back in your chair, just clicking
" on a buffer is easier than leaning back into the keyboard. That said, I'm
" really not a fan of the right-click popups.
set mouse=a
set mousemodel=extend

" Relative line numbers
set number
set relativenumber

" Hide the intro message
set shortmess+=atTI

" Use the same spacing for tabs and spaces. While more confusing perhaps which
" is used, I never actually care which is used. Go uses tabs, Prettier uses
" spaces. It's all 2 visual spaces though.
set shiftwidth=2
set tabstop=2

" Fold by indent
set foldmethod=indent
set foldlevel=20

" Store more oldfiles in the shada/viminfo file
if has('nvim')
  set shada=!,'1000,<500,s10,h
else
  set viminfo=!,'1000,<500,s10,h
endif

" Limit total completions to 10 items
set pumheight=15

" Highlight the cursor line
set cursorline

" Disable search highlighting by default. I enable this with an autocmd during
" searches and then disable it again when the search is done.
set nohlsearch

" More stable screen splitting
if has('nvim')
  set splitkeep=screen
endif

" Use ripgrep for grepping
set grepprg=rg\ --vimgrep\ --hidden
set grepformat=%f:%l:%c:%m

" Netrw settings here if I ever care to experiment with Netrw again. I'm still
" torn, I love it and hate it.
" let g:netrw_banner = 0
" let g:netrw_keepdir = 0
" let g:netrw_localcopydircmd = "cp -r"
" let g:netrw_list_hide = netrw_gitignore#Hide() " use .gitignore

" Using a 2-line command window reduces the number of "Press ENTER or type"
" prompts which is very helpful for staying focused.
set cmdheight=2

" Allow project-local config files
set exrc

" Completion menu options
set completeopt=menu,menuone

" Prompt for confirmation rather than simply failing the operation
set confirm

" Use spaces for tabs
set expandtab

" The best combination of options when searching. Ignore case by default, but
" if there are any uppercase characters in the search, then search case sensitive.
set ignorecase
set smartcase

" Use a 4-space soft line-break
set showbreak=\ \ \ \

" Always show the sign column even if there are no errors to prevent layout
" shifts when errors appear.
set signcolumn=yes

" Enable full terminal colors
set termguicolors
colorscheme habamax

" Auto save undo history
set undofile

" TODO: Not sure if this is actually necessary, I need to dig more into this.
set updatetime=100

" Default to replace all
set gdefault

" My approach to keymapping follows two important principles:
"
" 1. Keybindings should be pneumonic
" 2. The same finger should not be used twice in heavily used keybindings
"
" The first principle is important for learn-ability of keybindings, especially
" bindings that are less frequently used. For example, you can remember "fg"
" easily as it means "Find Git branches".
"
" The second principle is important for quickly executing common commands, and
" sometimes this results in breaking the first principle. For example, "ff"
" would be most ideal for "find files", however that motion is slower due to
" the same finger being used twice in the keybinding. In these cases,
" alternative keys can be used such as "fp" since cmd+p is a common shortcut in
" other editors such as VS Code, so it still has meaning. This second principle
" allows for more keybindings to be set while still keeping the speed of
" executing each keybinding relatively stable and fast.

" Shiftless command mode. I've debated this one some since other tools with Vim
" emulation don't use this, so it kind of makes life a little harder when
" working between tools. That said, my goal is to use other tools as little as
" possible, and tools like IntelliJ have good enough Vim emulation where it
" allows replicating this functionality.
"
" I've considered remapping colon to semicolon, but I often find myself
" pressing shift before colon for commands like :Duplicate or :G as it's easier
" do a chorded reach with the left hand then the alternative which would be
" non-shift click of semicolon, then right-shift the uppercase letter.
noremap ; :

" Map leader semicolon to the original semicolon motion to still allow using
" (next f/t match) since that motion is quite handy. I don't use it much, so
" the extra keypress is fine.
nnoremap <leader>; ;

" Really common shortcuts
noremap <silent> ,s <Cmd>w ++p<CR>
noremap <silent> ,S <Cmd>noa w<CR>
noremap <silent> ,q <Cmd>qa<CR>
noremap <silent> ,c <Cmd>clo<CR>

" Close window or buffer
noremap <silent> ,w <Cmd>call <SID>CloseWindowOrBuffer()<CR>

function! s:CloseWindowOrBuffer() abort
  " Auto-close the quickfix list if it's open
  if len(getqflist()) > 0 && &buftype !=# 'quickfix'
    cclose
  endif

  " Close the window if there are multiple windows open
  if winnr('$') > 1
    close
  else
    bdelete!
  endif
endfunction

" Move lines up and down in visual mode
xnoremap <silent> J :m '>+1<CR>gv=gv
xnoremap <silent> K :m '<-2<CR>gv=gv

" Join lines without losing your cursor position
nnoremap J mzJ`z

" Paste commands
nnoremap <leader>pa ggVG"_dP

" I frequently roll zv for visually selection which doesn't work great on my
" keyboard since I use a multi-function key for z/ctrl. This mapping sets
" zv to the same as C-v.
nnoremap zv <C-v>

" Modify j and k to navigate wrapped lines
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
