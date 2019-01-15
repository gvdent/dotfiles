" disable distro customization
set nocompatible

" determine filetype by extension / contents
filetype indent plugin on

" syntax highlighting
syntax on

" better command line completion
set wildmenu

" show partial commands in the last line of the screen
set showcmd

" seach highlighting <C-L> to temp disable.
set hlsearch

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
" nnoremap <C-L> :nohl<CR><C-L>

" Use visual bell instead of beeping when doing something wrong
set visualbell

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" And reset the terminal code for the visual bell.  If visualbell is set, and
" this line is also included, vim will neither flash nor beep.  If visualbell
" is unset, this does nothing.
set t_vb=

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set softtabstop=2
set expandtab

" set ls=2 " always show status line. on seconds thought, this is a silly idea

let mapleader = ","
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80

nnoremap ; :

" Reload current file
nnoremap <leader>r :edit!

" Strip all trailing whitespace from file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Open a new vertical split
nnoremap <leader>w <C-w>v<C-w>l

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
map      <C-t> :NERDTreeToggle<CR>

nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:\zs<CR>
vmap <leader>a: :Tabularize /:\zs<CR>

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=''
  call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

call plug#begin('~/.vim/plugged')


Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular' " Alignment of text

" Syntax highlighting
Plug 'leafgarland/typescript-vim'
Plug 'fatih/vim-go'
Plug 'kchmck/vim-coffee-script'

command -nargs=1 Sql :w | !psql "<args>" < %:t
command -nargs=1 SHql :w | !ssh hawaii psql "<args>" < %:t

fun! InsertHnPost ( arg ) "{{{
  "let command='r !curl --silent "'.expand(a:arg).'" | grep storylink | sed --expression "s/.*a href=\"\([^\"]*\)\" class=\"storylink\">\([^<]*\)<.*/[\2](\1)[hn](/"'
  let command='r !curl --silent "'.expand(a:arg).'" | grep storylink | sed --expression "s/.*a href=\"\([^\"]*\)\" class=\"storylink\">\([^<]*\)<.*/[\2](\1)[hn](/"'
  :exe command
  :exe 'r !echo "'.expand(a:arg).')"'
endfunction


"  curl https://news.ycombinator.com/item?id=17696023 | grep storylink | sed -e 's/.*a href="\([^"]*\)" class="storylink">\([^<]*\)<.*/\1 \2/'
"command -nargs=1 Hn :r !curl --silent "<args>" | grep storylink | sed --expression='s/.*a href="\([^"]*\)" class="storylink">\([^<]*\)<.*/\1 \2/'
command -nargs=1 Hn call InsertHnPost( '<args>' )

call plug#end()
