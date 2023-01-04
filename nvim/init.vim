call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'ghifarit53/tokyonight-vim'
Plug 'davidhalter/jedi-vim'
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons' " Instala conjutno de icones de DEV
Plug 'sheerun/vim-polyglot' " Habilita o highlight para infinidade de lingagens
Plug 'Xuyuanp/nerdtree-git-plugin' " Adiciona icons do git ao nerdtree
call plug#end()

" -------------------------------- Global sets -----------------------------
"   Conjunto de configurações de sets de configurações.
"Para melhorar scroll, habilitar mouse, configurar tab, etc
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
set ignorecase       " Ingore case in search
set smartcase        " Consider case if there is a upper case character
set scrolloff=8      " Quantidade de linhas que v'ao ficar acima e abaixo do cursor enquanto scroola
"  set colorcolumn=100  " Draws a line at the given line to keep aware of the line size
set signcolumn=yes   " Add a column on the left. Useful for linting
set cmdheight=2      " Numero da quantidade de linhas na parte de comandos. Util para quando aparece mensagem de erro muito grandes
set updatetime=100   " Time in miliseconds to consider the changes
set encoding=utf-8   " The encoding should be utf-8 to activate the font icons
set nobackup         " No backup files
set nowritebackup    " No backup files
set splitright       " Create the vertical splits to the right
set splitbelow       " Create the horizontal splits below
set autoread         " Update vim after file update from outsid
set relativenumber
set background=dark
set mouse=a
set termguicolors
filetype on          " Detect and set the filetype option and trigger the FileType Event
filetype plugin on   " Load the plugin file for the file type, if any
filetype indent on   " Load the indent file for the file type, if any
" ---------------------------------------------------------------------------

" -------------------------------- Remaps ----------------------------------
"   Mapeamento de atalhos de teclado
" Shortcuts for split navigation
map <C-h> <C-w>h " direita
map <C-j> <C-w>j " Para baixo
map <C-k> <C-w>k " Para cima
map <C-l> <C-w>l " direita

" ---------------------------------------------------------------------------

" ---------------------------- Auto Comandos --------------------------------
"   Comandos que são executados automaticamente quando acontece uma ação

" ---------------------------------------------------------------------------

" -------------------------------- Themes ----------------------------------
"   Thema e configurações do thema
let g:tokyonight_style='night' " available: night, storm
let g:tokyonight_enable_italic=1
colorscheme tokyonight

" ---------------------------------------------------------------------------

" -------------------------------- Airline ----------------------------------
"   Configurações do Airline
let g:airline#extensions#tabline#enabled = 1 "Habilita os buffers para ficar como abas em cima, como os arquivos abertos no vscode
let g:airline_powerline_fonts = 1 " Usa a nerdfonts como caracteres

" ---------------------------------------------------------------------------

" -------------------------------- Nerd Tree -------------------------------------
"   Configurações do Nerd Tree
nmap <C-a> :NERDTreeToggle<CR> " Seta o control + a para abrir fechar o nerdtree
" --------------------------------------------------------------------------------



" Referencias
" https://www.manualdocodigo.com.br/vim-basico/