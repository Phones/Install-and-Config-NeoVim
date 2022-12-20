call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'ghifarit53/tokyonight-vim'
Plug 'valloric/youcompleteme'
call plug#end()


syntax enable

set number
set relativenumber
set background=dark
set mouse=a
set termguicolors

let g:tokyonight_style='night' " available: night, storm
let g:tokyonight_enable_italic=1

colorscheme tokyonight
