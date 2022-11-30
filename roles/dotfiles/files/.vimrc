if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

execute pathogen#infect()

syntax enable
set background=dark
colorscheme tendercontrast
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts=1
set laststatus=2

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set expandtab
set tabstop=2
set noautoindent
set nobackup		" do not keep a backup file, use versions instead
set nowritebackup	" dont want a backup file while editing
set history=50		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching
set showmatch		" show matching parenthesis
set smartcase		" ignore case if search pattern is lower case
set visualbell
set relativenumber
set number
set autowrite

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Disable mouse
if has('mouse')
  set mouse=
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  autocmd FileType text setlocal textwidth=78

  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  
  autocmd FileType go nmap <leader>b  <Plug>(go-build)
  autocmd FileType go nmap <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <leader>t  <Plug>(go-test)

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
else
  set autoindent
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" key bindings
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
let mapleader = ","
let g:crtlp_map = '<c-p>'
map <C-n> :NERDTreeToggle<CR>

" neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#max_list = 10 
let g:neocomplete#sources#syntax#min_keyword_length = 3
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_play_open_browser = 0
