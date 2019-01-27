set runtimepath+=~/.vim/bundle/nerdtree
set runtimepath+=~/.vim/bundle/lightline


let mapleader=" "
if !has('gui_running')
  set t_Co=256
endif
set term=xterm-256color
set nonumber
set ruler
set tabstop=2
set shiftwidth=2 " controls the depth of autoindentation
set expandtab    " converts tabs to spaces
set laststatus=2 " show status line always

autocmd Filetype cpp setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4

" vim cpp highlighter plugin settings
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

set autoread
syntax on
syntax enable
set background=dark
let g:solarized_termcolors=256
"colorscheme dosbox
" colorscheme solarized
colorscheme monokai " My favorite colorscheme

set wildmenu

set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set ruler " current posn

set cmdheight=2 " cmd bar height

set hid " hide buffer when not in use

set backspace=eol,start,indent " backspace
set whichwrap+=<,>,h,l 

set ignorecase " case insensitive search

set smartcase " smartsearch

set hlsearch " highlighted search

set incsearch " incremental search like browsers

set lazyredraw " delay redraw during macro exec

set magic " regex

set showmatch " matching braces

set mat=2 " blinks while matching braces, how many tenth

" stop sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" set foldcolumn=1 " left extra bt margin

set encoding=utf8 " default encoding

" stop backup to reduce overhead, keep it in harddisk/git
" set nobackup
" set nowb
" set noswapfile we may need swap file

set lbr " line break
set tw=500 " lbr 500 char

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Michael Naumann's idea
" * for searching current selection in visual mode 
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>

" forward and backward search
map <leader> /  


map <leader>bd :tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>t :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>tn :tabnext 

map <leader>qt <C-w>N

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

nmap <leader>w :wqa!<cr>
nmap <leader>q :q!<cr> 
set tags=/remote/sweifs/PE/products/dgplt/o_r1_rel/clientstore/dgplt_o_r1_rel_build2/nwtn/src/tags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" autocmd vimenter * NERDTree
let g:lightline = {
  \   'colorscheme': 'wombat',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   }
  \ }
let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
	\   'left': '', 'right': '' 
  \}
" Set default compilers for each filetype
if ! exists('g:wandbox#default_compiler')
    let g:wandbox#default_compiler = {}
endif
let g:wandbox#default_compiler = {
\   'cpp' : 'clang-head',
\   'ruby' : 'ruby-1.9.3-p0',
\ }

" Set default options for each filetype.  Type of value is string or list of string
if ! exists('g:wandbox#default_options')
    let g:wandbox#default_options = {}
endif
let g:wandbox#default_options = {
\   'cpp' : 'warning,optimize,boost-1.55',
\   'haskell' : [
\     'haskell-warning',
\     'haskell-optimize',
\   ],
\ }

" Set extra options for compilers if you need
let g:wandbox#default_extra_options = {
\   'clang-head' : '-O3 -Werror',
\ }

" For all filetypes, use default compiler and options
noremap <Leader>wb :Wandbox<CR>
" For specific filetypes, specify compilers to use
augroup wandbox-settings
    autocmd!
    autocmd FileType cpp noremap <buffer><Leader>ww :Wandbox --compiler=gcc-head,clang-head<CR>
    autocmd FileType cpp noremap <buffer><Leader>wg :Wandbox --compiler=gcc-head<CR>
    autocmd FileType cpp noremap <buffer><Leader>wc :Wandbox --compiler=clang-head<CR>
augroup END

" CUSTOM C++ SPECIFIC REMAPS
inoremap () ()<Left>
inoremap (; ();<Left><Left>
inoremap { {}<Left>
inoremap {<CR> {<CR><CR>}<left><up><space><space>
inoremap <> template<typename><left><space>
inoremap {; {<CR><CR>};<left><left><up><space><space>
