set nocompatible
syntax on 

" Wrap and scroll options 
set wrap 
set linebreak 
set scrolloff=10 

" Show line numbers 
set number 

" Cursor 
set cursorline 
set nocursorcolumn 

" Indentations 
set shiftwidth=4 
set tabstop=4 
set expandtab 

" Backup 
set nobackup 

" Search 
set hlsearch  " Use highlighting during search 
set incsearch " Highlight matching characters 
set showmatch " Show matching words 

set ignorecase 
set smartcase 

" Interface 
set showmode 
set showcmd 
colorscheme kolor
set background=dark 

" History 
set history=100 

" Auto completion menu 
set wildmenu 
set wildmode=list:longest,full 
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx 

" PLUGINS -----------------------------------------------------------------{{{ 
" Plugins code here 
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl --create-dirs -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged') 
    Plug 'dense-analysis/ale' 

    Plug 'preservim/nerdtree' 
    Plug 'ryanoasis/vim-devicons' 

    Plug 'itchyny/lightline.vim' 

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 

    Plug 'jiangmiao/auto-pairs'

    Plug 'vim-scripts/restore_view.vim'
call plug#end() 

"}}} 

" MAPPINGS ----------------------------------------------------------------{{{ 
" Mappins code here 
nnoremap <C-n> :NERDTree<CR> 
nnoremap <C-t> :NERDTreeToggle<CR> 

nnoremap <silent> <leader>o :FZF<CR> 

" Foldings. F9 to open/close folds in normal, create folding in visual
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" Foldings. Space for toggle fold (when folding mode Manual and cusor on fold in NORMAL).
" Create fold in visual mode
inoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf


" }}} 

" VIMSCRIPT ---------------------------------------------------------------{{{ 
" Enable the marker method of folding 
augroup filetype_vim 
    autocmd! 
    autocmd FileType vim setlocal foldmethod=marker 
augroup END 

" If current file type is HTML, set indentation to 2 spaces 
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab 

" Folding - let Vim define folding automatically by indent level
" but also allow to create folds manually. 
" Save folds (view) on close file
augroup vimrc
    au BufReadPre * setlocal foldmethod=indent
    au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

" If Vim version is greater or equal to 7.3, enable undofile 
if version >= 703 
    set undodir=~/.vim/backup 
    set undofile 
    set undoreload=1000 
endif 

" Display cursorline and cursorcolumn ONLY in active window 
augroup cursor_off 
    autocmd! 
    autocmd WinLeave * set nocursorline nocursorcolumn 
    autocmd WinEnter * set cursorline cursorcolumn 
augroup OFF 

" Cursor shapes for different modes
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" reset the cursor on start (for older versions of vim, usually not required)
augroup cursorMode
    au!
    autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" NERDTree for Vim open with no file 
autocmd StdinReadPre * let s:std_in=1 
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif 

" Remember position of last edit and return on reopen 
if has("autocmd") 
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif 
endif 

" }}} 

" STATUS LINE -------------------------------------------------------------{{{ 
" Reset statusline 
set statusline= 

" Left side 
set statusline+=\ %F\ %M\ %Y\ %R 

" Separator 
set statusline+=%= 

" Right side 
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\%p%% 

" Status 
set laststatus=2 
" }}} 
