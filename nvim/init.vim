call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'ghifarit53/tokyonight-vim'
Plug 'davidhalter/jedi-vim'
call plug#end()

" -------------------------------- Global sets -----------------------------
syntax enable
set number
" ---------------- Config Tab Spaces----------
set tabstop=4        "Set tab to 4 spaces
set softtabstop=4    " Show existing tab with 4 spaces width
set shiftwidth=4     " When indenting with '>', use 4 spaces width
set expandtab        " On pressing tab, insert 4 spaces
" --------------------------------------------
set hidden           " Hides the current buffer when a new file is openned
set incsearch        " Incremental search
set relativenumber
set background=dark
set mouse=a
set termguicolors
" ---------------------------------------------------------------------------


let g:tokyonight_style='night' " available: night, storm
let g:tokyonight_enable_italic=1

colorscheme tokyonight
