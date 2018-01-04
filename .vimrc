" Allow scroll screen with mouse
set mouse=a ttymouse=xterm2

" Highlight for Java
:let java_highlight_debug=1
:let java_highlight_all=1

" Encode setting
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

" Color setting
syntax on
" colorscheme monokai
" colorscheme molokai
" set t_Co=256

" Autoindent
set autoindent

" Show line number
set number
" Highlight for line number
highlight LineNr ctermfg=240

" Set showing tab width
set tabstop=4
" Set inserting tab width
set shiftwidth=4
" Treat tab as tab
set noexpandtab
"
set softtabstop=0

" Tab settings
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" Autocomplete for brackets
inoremap {<Enter> {}<Left><CR><ESC><S-o><Tab>
inoremap [<Enter> []<Left><CR><ESC><S-o><Tab>
inoremap (<Enter> ()<Left><CR><ESC><S-o><Tab>

" inoremap { {}<LEFT>
" inoremap [ []<LEFT>
" inoremap ( ()<LEFT>
" inoremap " ""<LEFT>
" inoremap ' ''<LEFT>
" vnoremap { "zdi^V{<C-R>z}<ESC>
" vnoremap [ "zdi^V[<C-R>z]<ESC>
" vnoremap ( "zdi^V(<C-R>z)<ESC>
" vnoremap " "zdi^V"<C-R>z^V"<ESC>
" vnoremap ' "zdi'<C-R>z'<ESC>

" Not to stop cursor at begging of the line or end of the line
set whichwrap=b,s,h,l,<,>,[,]

" Persistent Undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif


" Paste mode
nnoremap pt :set paste<CR>
