call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'ghifarit53/tokyonight-vim'
Plug 'davidhalter/jedi-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons' " Instala conjutno de icones de DEV
Plug 'sheerun/vim-polyglot' " Habilita o highlight para infinidade de lingagens
Plug 'Xuyuanp/nerdtree-git-plugin' " Adiciona icons do git ao nerdtree
"Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
" Plug 'neovim/nvim-lspconfig'
" Plug 'Xuyuanp/scrollbar.nvim'
Plug 'dstein64/nvim-scrollview'
Plug 'lervag/vimtex'
" -------- Faz a instalação desse plugin apenas para neovim -------------
if (has("nvim"))
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
endif
" -----------------------------------------------------------------------
call plug#end()
set noshowmode
set noruler
" -------------------------------- Global sets -----------------------------
"   Conjunto de configurações de sets de configurações.
"Para melhorar scroll, habilitar mouse, configurar tab, etc
syntax enable
set number
" Use apenas o registro interno (unnamed) para operações de área de transferência
set clipboard=unnamed
set guioptions-=a
" ---------------- Config Tab Spaces ----------
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
set updatetime=100   " Time in miliseconds to consider the changes
set encoding=utf-8   " The encoding should be utf-8 to activate the font icons
set nobackup         " No backup files
set nowritebackup    " No backup files
set splitright       " Create the vertical splits to the right
set splitbelow       " Create the horizontal splits below
set equalalways      " garante que as janelas sejam divididas igualmente em tamanho
set cmdheight=2      " aumenta a altura do prompt do terminal para 2 linhas. Tbm é util quando tem uma mensagem de erro de grande
set autoread         " Update vim after file update from outsid
" set relativenumber
set background=dark
set mouse=a
set termguicolors
highlight Terminal ctermbg=black guibg=black
set guifont=Monospace\ 10
set clipboard+=unnamed
filetype on          " Detect and set the filetype option and trigger the FileType Event
filetype plugin on   " Load the plugin file for the file type, if any
filetype indent on   " Load the indent file for the file type, if any
" ---------------------------------------------------------------------------
set clipboard=unnamedplus
" -------------------------------- Remaps ----------------------------------
"   Mapeamento de atalhos de teclado
" Shortcuts for split navigation
map <C-h> <C-w>h " direita
map <C-j> <C-w>j " Para baixo
map <C-k> <C-w>k " Para cima
map <C-l> <C-w>l " direita

" Cria uma nova aba
nmap te :tabe<CR>

" Navigate between buffers
nmap ty :bn<CR>
nmap tr :bp<CR>

" Delete a buffer
nmap td :bd<CR>

" Create splits
nmap th :split<CR>
nmap tv :vsplit<CR>

" Close splits and others
nmap tt :q<CR>

" Call command shortcut
nmap tc :!

" Remap para fazer o control + a. Seleciona todo o arquivo
nnoremap <c-a> <esc>ggVG<cr>

" Map <C-s> to save the current file
nnoremap <C-s> <esc>:w<CR>
inoremap <C-s> <Esc>:w<CR>a

" " Configuração do atalho para abrir um terminal e posicioná-lo à direita
nnoremap <leader>t :vsplit %<CR>:terminal<CR>

" Faz com que o cursor passe para o final da linha de cima, quando chegar no
" comeco da linha
:inoremap <expr> <Left>  col('.') == 1 ? '<Up><End>' : '<Left>'
" Mapeia Shift + Tab para voltar as tabulações no mode de inserção
"inoremap <S-Tab> <C-d>
" Mapeia Shift + Tab para voltar as tabulações no modo normal
"nnoremap <S-Tab> <<
" Navega para o split da direita
nnoremap <C-Right> <C-w>l
inoremap <C-Right> <Esc><C-w>l i


" Navega para o split da esquerda
nnoremap <C-Left> <C-\><C-n><C-w>h
inoremap <C-Left> <C-\><C-n><C-w>h i

" Navega para o split da esquerda
nnoremap <C-Left> <C-\><C-n><C-w>h
inoremap <C-Left> <C-\><C-n><C-w>h i

" Navega para o split de baixo
nnoremap <C-Down> <C-w>j
inoremap <C-Down> <C-o><C-w>j

" Navega para o split de cima
nnoremap <C-Up> <C-w>k
inoremap <C-Up> <C-o><C-w>k


" Seleciona a linha atual inteira e cola o conteudo selecionado na area de
" transferiencia do modo insert
" nnoremap <C-l> :<C-u>normal! V<CR>
" inoremap <C-l> <C-r>+
nnoremap <C-l> :<C-u>normal! V<CR>
" inoremap <C-l> <C-r>+

" Mapear Control + C para copiar e Control + V para colar
" Control + C
nnoremap <C-c> "+y
vnoremap <C-c> "+y
inoremap <C-c> <C-\><C-n>"+y

" Control + V
nnoremap <C-v> "+p
vnoremap <C-v> "+p
inoremap <C-v> <C-\><C-n>"+p

" Mapeia o atalho Ctrl+X para recortar no modo visual e normal
vnoremap <C-x> "+d
nnoremap <C-x> "+d

" Mapeamento de teclas para substituição global
nnoremap <C-f> :set hlsearch<CR> :%s///gc<Left><Left><Left>
" Mapeamento de teclas para substituição global com destaque de palavras
" nnoremap <C-f> :set hlsearch<CR>:%s/\<<C-r><C-w>\>/&/gc<Left><Left><Left>

" Mapear Ctrl + l para selecionar toda a linha em todos os modos
noremap <C-l> V
xnoremap <C-l> V
onoremap <C-l> V
inoremap <C-l> <C-o>V


" Mapeia o comando Control + Z para desfazer no modo normal e de inserção
nnoremap <C-z> u
inoremap <C-z> <C-o>u


" Mapeia o comando Control + Y para refazer no modo normal e de inserção
nnoremap <C-y> <C-r>
inoremap <C-y> <C-o><C-r>


" Mapeia o comando Control + D para excluir a palavra sob o cursor no modo normal
nnoremap <C-d> diw
inoremap <C-d> <C-o>diw
" --------------------------------------------------------------------------

" ---------------------------- Barra de scroll para o neovim ----------------
" augroup ScrollbarInit
"   autocmd!
"   autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
"   autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
"   autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
" augroup end

let g:scrollview_excluded_filetypes = ['nerdtree']
let g:scrollview_current_only = v:true
let g:scrollview_winblend = 75
" Position the scrollbar at the 80th character of the buffer
let g:scrollview_base = 'buffer'
let g:scrollview_column = 80
" Enable all sign groups (defaults to ['diagnostics', 'search']).
" Set to the empty list to disable all sign groups.
" let g:scrollview_signs_on_startup = ['all']

" Show diagnostic signs only for errors.
let g:scrollview_diagnostics_severities =
      \ [luaeval('vim.diagnostic.severity.ERROR')]

" Define a barra para ficar a direita
let g:scrollview_base = 'right'
let g:scrollview_column = 1

" Habilita o mouse para a barra
let g:scrollview_auto_mouse = 1

"Define a opacidade e cor da barra
let g:scrollview_winblend = 0
highlight ScrollView guibg=red
let g:scrollview_winhighlight = 'ScrollView'
"---------------------------------------------------------------------------


" ---------------------------- Minimizar contexto de funcao ----------------
"---------------------------------------------------------------------------

" ---------------------------- Functions ----------------------------------------
" Função que possibilita comentar e descomentar uma trecho de codigo
" selecionado
function! CommentLines()
    let comment_character = ''
    let uncomment_regex = ''
    if &filetype == 'python'
        let comment_character = '#'
        let uncomment_regex = '^\s*# '
    elseif &filetype == 'c' || &filetype == 'cpp'
        let comment_character = '//'
        let uncomment_regex = '^\s*\/\/ '  " adicione a barra invertida aqui
    endif

    let uncomment = 0
    let lines = getline("'<", "'>")
    for line in lines
        if line =~ uncomment_regex
            let uncomment = 1
            break
        endif
    endfor

    " Adiciona ou remove os comentários
    if uncomment
        silent! execute ":'<,'>s/".uncomment_regex."//"
    else
        silent! execute ":'<,'>s,^,".comment_character." ,"
    endif
endfunction

vnoremap <silent> <leader>/ :<C-u>call CommentLines()<CR>
" ------------------------------------------------------------------------------

" ---------------------------- Auto Comandos --------------------------------
"   Comandos que são executados automaticamente quando acontece uma ação
" Quando selecionar uma palavra, ele marca todas as palavras iguais
function! HighlightWordUnderCursor()
    if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
        exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/'
    else
        match none
    endif
endfunction

autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()

" Muda o formato do cursor para um cursor de texto quando o mouse passa sobre o texto
"Copy code
let &t_SI .= "\<Esc>[5 q"
let &t_SR .= "\<Esc>[4 q"
let &t_EI .= "\<Esc>[1 q"
"
augroup mySettings
  autocmd!
  autocmd InsertEnter * set cul
  autocmd InsertLeave * set nocul
augroup END

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
nmap <C-t> :NERDTreeToggle<CR> " Seta o control + t para abrir fechar o nerdtree
" --------------------------------------------------------------------------------

" -------------------------------- Nerd Tree -------------------------------------
"   Ferramente para configurar linters e fixers
" let g:ale_linters = {
"\}

"let g:ale_fixers = {
"\   '*': ['trim_whitespace'],
"\}

"let g:ale_fix_on_save = 1
" --------------------------------------------------------------------------------

" ------------------------------ Telescope ---------------------------------------
if (has("nvim"))
    " Configuração do Telescope para buscar arquivos com Control + F
    nnoremap <C-p> :Telescope find_files<CR>
    nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
    nnoremap <leader>fh <cmd>Telescope help_tags<cr>
endif
" --------------------------------------------------------------------------------

" ----------------------- COC (Conquer of Completion) ----------------------------
"   Configurações do COC, linters, autocomplete, puglins

let g:coc_global_extensions = ['coc-snippets', 'coc-explorer']

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" --------------------------------------------------------------------------------

" ------------------------------------------------ Coc Snippets ----------------------------------------------------

" ----------------------------------------------------------------------------------------------------------------------

" --------------------------------------- Coc Explorer -----------------------------------
:nnoremap <space>e :CocCommand explorer<CR>

let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'cocConfig': {
\      'root-uri': '~/.config/coc',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'tab:$': {
\     'position': 'tab:$',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   },
\   'buffer': {
\     'sources': [{'name': 'buffer', 'expand': v:true}]
\   },
\ }

" Use preset argument to open it
nnoremap <space>ed :CocCommand explorer --preset .vim<CR>
nnoremap <space>ef :CocCommand explorer --preset floating<CR>
nnoremap <space>ec :CocCommand explorer --preset cocConfig<CR>
nnoremap <space>eb :CocCommand explorer --preset buffer<CR>

" List all presets
nnoremap <space>el :CocList explPresets
" Configuração do Coc Explorer com ícones
let g:coc_explorer_disable_nerdfonts = 0
let g:coc_explorer_icon_enable_nerdfont = 1
" ----------------------------------------------------------------------------------------


" Desativa os :format :x :s do clangd
let g:clangd_diagnostic_virtual_text = 0
let g:coc_diagnostic_virtual_text = 0

" Referencias
" https://www.manualdocodigo.com.br/vim-basico/
