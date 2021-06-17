""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIG TO MY TASTE "
""""""""""""""""""""""""""""""""""""

set nocompatible
" Hide buffer when not in use
set hidden 
" Set default tab and default indentation width to 2 space
set tabstop=2
set shiftwidth=2 
set expandtab
set softtabstop=2
set autoindent
" Set number of commands to remember
set history=10000
set showmatch
set incsearch
set hlsearch
" make searches case-insensitive only if they contain upper case characters
set ignorecase smartcase
" highlight the current line
set cursorline
set cmdheight=2
set switchbuf=useopen
" Always show tabl bar at the top
set showtabline=2
set shell=bash
" keep more content when scrolling off the end of the budder
set scrolloff=3
" Do not make backups at all (.swp)
set nobackup
set nowritebackup
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" Enable highlighting for syntax
syntax on
filetype plugin indent on
" Use emacs-style tab completion when selecting files etc
set wildmode=longest,list
" make tab completition for files/buffers act like bash
set wildmenu
let mapleader=","
" Modelines (comments that set vim options on a per-file basis)
set modeline
set modelines=3
" If a file changes outside of vim, automatically reload it without asking 
set autoread
" Show diffs side-by-side not above/below
set diffopt=vertical
" Always show the sign column
set signcolumn=no
" True color mode
if !has('gui_running')
	  set t_Co=256
endif
set term=xterm-256color
"Completion option
:set completeopt=menu,preview
set laststatus=2 " show status line always
set encoding=utf-8
" Set color to my taste
:color lucius
LuciusBlackHighContrast

"""""""""""""""""""""""
" Working with Folds  "
"""""""""""""""""""""""
set omnifunc=syntaxcomplete#Complete
set viewdir=$HOME/.vimviews/ " For creating folds
au BufWinLeave * mkview
au BufWinEnter * silent loadview

" Michael Naumann's idea ---- I have no idea how it works
" * for searching current selection in visual mode 
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>

""""""""""""""""""""""
" CUSTOM KEYMAPS      "
""""""""""""""""""""""

" In a wrapped line navigate up and down using j and k
" as opposed to the cumbersome gk/gj
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Close all other splits
nnoremap <leader>o :only<cr>

" Align selected lines
vnoremap <leader>i :!align<cr>

" CUSTOM C++ SPECIFIC REMAPS
inoremap () ()<Left>
inoremap (; ();<Left><Left>
inoremap { {}<Left>
inoremap {<CR> {<CR><CR>}<left><up><space><space>
inoremap <> template<typename><left><space>
inoremap {; {<CR><CR>};<left><left><up><space><space>

"""""""""""""""""""""""""""""""""""""""""
" CUSTOM KEYCODE MAPS
"""""""""""""""""""""""""""""""""""""""""
ca tn tabnew
ca th tabp
ca tl tabn
ca te tabedit


"""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS          
"""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
	" Clear all autcmds in the group
	autocmd!
	"stolen from gary's
	autocmd FileType cpp,ruby,yaml,html,css,sass setlocal ai sw=2 sts=2 et
	autocmd FileType python setlocal ai sw=4 sts=2 et

	" Don't syntax highlight markdown
	autocmd! FileType mkd setlocal syn=off 

	" *.md is markdown
	autocmd! BufNewFile,BufRead *.md setlocal formatoptions+=t

	" js, json
	autocmd! FileType javascript,json set sw=2 sts=2 expandtab

	" Compute syntax higlighting from beginning of file. (By default,
	" vim only looks 200 lines back, which can make it highlight code 
	" incorrectly in some long files).
	autocmd BufEnter * :syntax sync fromstart

	" Vim 8.2 adds built-in JSX support which seems broken. Setting these
	" filetypes lets the installed plugins deal with JSX/TSX instead.
	autocmd bufnewfile,bufread *.tsx set filetype=typescript.tsx
	autocmd bufnewfile,bufread *.jsx set filetype=javascript.jsx
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw appearance: Make it look like Nerdtree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do
" completition
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
	let col = col('.') - 1
	if !col
		return "\<tab>"
	endif

	let char = getline('.')[col - 1]
	if char =~ '\k'
		" There's an identifier before the cursor, complete it
		return "\<c-p>"
	else
		return "\<tab>"		
	endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SHORTCUT TO REFERENCE CURRENT FILE's PATH IN CMD LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap <expr> %% expand(%:h').'/'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
	let old_name = expand('%')
	let new_name = input('New file name: ', expand('%'), 'file')
	if new_name != '' && new_name != old_name
		exec ':saveas ' . new_name
		exec ':silent !rm ' . old_name
	endif
endfunction
map <leader>n :call RenameFile()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Incremental Reading using Cloze for my markdown notes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:toggleCloze = 0

function! ToggleCloze(...)
  if a:0 == 1 "toggle behavior
    let g:toggleCloze = 1 - g:toggleCloze
  endif

  if g:toggleCloze == 0 "normal action, do the hi
		exec 'highlight cloze1 ctermfg=white guifg=white ctermbg=white guibg=white | match cloze1 /\%>' . line('.') . 'l.{{.\{-\}}}/'
  else 
    exec 'highlight cloze ctermfg=black guifg=black ctermbg=white guibg=white | match cloze /{{.*}}/'
  endif
endfunction

autocmd CursorMoved *.md call ToggleCloze()
map <F2> :call ToggleCloze(1)<CR>

try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry




