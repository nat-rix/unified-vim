" Requirements
" ============

"  * nvim
"  * vim-plug
"   install it by moving `https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
"   to `$HOME/.local/share/nvim/site/autoload/plug.vim`
"   and then execute `:PlugInstall`


" Basic Configuration
" ===================

" Do not try to act like VI
" Enable more modern features that might be confusing for vi users
set nocompatible

" Set the leader key
let mapleader = ','

" Enable syntax and plugins (for netrw)
syntax enable
filetype plugin on

" Enable automatic indents
set autoindent

" Backspacing in insert mode behaves as one would expect
set backspace=indent,eol,start

" On <TAB> insert blanks according to 'shiftwidth'
set smarttab

" Number of spaces that a <Tab> in the file counts for
set tabstop=4

" Insert spaces instead of tabs
set expandtab

" Size of an indentation in spaces
set shiftwidth=4

" Supports Ctrl+a and Ctrl+x for following number formats
set nrformats=bin,hex,octal

" Don't pass messages to |ins-completion-menu|
set shortmess+=c

" Only show the left most column with warnings and errors if there are any
set signcolumn=auto

" Show cursor position in status line
set ruler

" Search while typing
set incsearch

" Highlight all search results
set hlsearch

" Always keep an minimum offset of 5 lines between cursor and screen
set scrolloff=5

" Set file encoding for new files to utf-8 (see `:h fileencodings`)
setglobal fileencoding=utf-8

" Rather hide a buffer instead of abandoning it
set hidden

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on, this is necessary for most plugins
" and standard vim behaviour
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell

" Visual bell, ignored by nvim
set t_vb=

" Timeout for mapped key sequences
set tm=500

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/target/*

" Only be case sensitive on search if contains upper case letters
set smartcase

" Enable relative number display at left-most column
set relativenumber

" But show absolute line number at the cursor line
set number

" Set the width of the number column to 3
set numberwidth=3

" Allow `//`-Comments for json files (see jsonc-format)
autocmd FileType json syntax match Comment +\/\/.\+$+

" Soft-wrap line if too long
set wrap

" Let Cargo.lock files have less autocomplete priority than Cargo.toml
set suffixes+=.lock

" Only show tab line if there are minimum 2 of them
set showtabline=1

" Remember the cursor position in shada-file and restore it
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Make Cmdline auto-complete great again
set wildmode=longest,list

" Delete trailing white space on save, useful for some filetypes
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
if has("autocmd")
    autocmd BufWritePre *.rs,*.txt,*.js,*.ts,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif 

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

" Quickly open a markdown buffer for scribble
map <silent> ß :noswapfile enew<CR>:setlocal buftype=nofile<CR>:setlocal bufhidden=hide<CR>file scratch<CR>

" Use tab for trigger completion with characters ahead and navigate.                 
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :                                         
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <C-space> to trigger completion.
inoremap <silent><expr> <C-space> coc#refresh()

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window                  
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction                                                      

" Persisten undo
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

" Fuzzy finding
" =============

" Enable recursive searching with find
"   :find - can now fuzzy-find
set path+=**

" Enable tab-completion for fuzzy-find
set wildmenu
set wildchar=<TAB>


" Autocompletion
" ==============

" Only show autocompletion menu.
" Do not show preview window automatically (default: "meu,preview").
" Also see `:help preview`
set completeopt=menu


" Snippets
" ========

noremap \html :-1read $HOME/.config/nvim/snippets/html<CR>3<DOWN>14<RIGHT>a
noremap \rust :-1read $HOME/.config/nvim/snippets/rust<CR>o
noremap \c :-1read $HOME/.config/nvim/snippets/c<CR>o
noremap \t a<></><ESC>3<LEFT>i
noremap \fn ofn () {<CR>}<ESC><UP>$3<LEFT>i
noremap \il o<ESC>oimpl  {<CR>}<ESC><UP>$<LEFT>i


" Copy/Paste
" ==========

" In vim there are so-called registers that can be used for copy-paste.
" You can address a register with `"`, so for example `"ayy` yanks the current
" line into register "a". `""` is the default register. Also there are
" number-registers that backup up to 9 old values. So the register `"1`
" contains what was stored one yank ago.
" There are some other special registers:
"   ". - the last inserted text
"   "% - current file path
"   ": - the most recently executed command
"   "* - X11's PRIMARY-clipboard
"   "+ - X11's CLIPBOARD-clipboard
"   "_ - black hole, swallows up everything, the void
"   "\ - last search pattern
"   "= - very special. Evaluates an user-specified expression,
"        see `:h expression`

" Use Ctrl+c and Ctrl+v for copy/paste from system clipboard
noremap <C-v> "+p
noremap <C-c> "+y
" Also paste in insert mode
inoremap <C-v> <ESC>"+pa


" Plugins
" =======

call plug#begin('$HOME/.vim/plugged')

Plug 'flazz/vim-colorschemes'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'truedoctor/bufexplorer'

Plug 'cespare/vim-toml'

Plug 'chr4/nginx.vim'

" TODO: Consider some plugins by tpope

call plug#end()

let g:coc_global_extensions=[
    \'coc-yank',
    \'coc-rust-analyzer',
    \'coc-python',
    \'coc-java',
    \'coc-html',
    \'coc-json',
    \'coc-omnisharp',
    \'coc-xml',
    \'coc-yaml',
    \'coc-tsserver',
    \'coc-markdownlint',
\]


" Plugin Configuration
" ====================

" coc-yank
" --------
" > see coc-settings.json
hi HighlightedyankRegion term=bold ctermbg=4 guibg=#13354A

" bufexplorer
" -----------

let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='mru'      
nnoremap <leader>o :BufExplorer<cr>

" Mouse
" =====

" Enable mouse navigation for all modes except for prompts
set mouse=a

" When typing hide mouse (only works in gui)
set mousehide=on

set mousemodel=popup_setpos


" Standard Status Line
" ====================

" Define colors for status line
" For a definition of cterm colors s. https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit
let s:unitheme='theonlyyetdefinedtheme'
if s:unitheme == 'theonlyyetdefinedtheme'
    colorscheme gruvbox
    let g:gruvbox_contrast_dark = 'hard'
    let g:gruvbox_contrast_light = 'hard'
    hi UniStatusBg                             ctermbg=252 ctermfg=0
    hi UniStatusModestr       cterm=bold       ctermbg=252 ctermfg=0
    hi UniStatusFile          cterm=italic     ctermbg=252 ctermfg=16
    hi UniStatusEnc                            ctermbg=252 ctermfg=239
    hi Normal                                  ctermbg=none
endif

" Function generating text for current mode
function! UnifiedGetMode() abort
    return {
        \ 'n': 'NORMAL',
        \ 'v': 'VISUAL',
        \ 'V': 'V LINE',
        \ '':  'V BLOCK',
        \ 'i': 'INSERT',
        \ 'R': 'REPLACE',
        \ 'Rv': 'V-REPLACE',
        \ 'c': 'CMD',
        \}[mode()]
endfunction

" Function generating file flags
function! UnifiedGenModsl() abort
    let l:val = ''
    if &modified
        let l:val .= '*'
    endif
    if &readonly
        let l:val .= ' readonly'
    endif
    return l:val
endfunction

" Function generating status line
function! UnifiedGensl() abort
    let l:coc_status = coc#status() . get(b:,'coc_current_function','')
    if empty(l:coc_status)
    else
        let l:coc_status = '%#CocListFgMagenta#( ' . l:coc_status . ' )%#UniStatusBg#'
    endif
    let l:modestr = '%#UniStatusModestr# %{UnifiedGetMode()}%#UniStatusBg#'
    let l:filepath = ' │ %#UniStatusFile#%t%#UniStatusBg#'
    let l:filepath .= '%{UnifiedGenModsl()}'
    let l:linecol = '%#ModeMsg#| c%c L%l/%L%#UniStatusBg#'
    let l:fileenc = '%#UniStatusEnc#%{&fileencoding}%#UniStatusBg#'
    let l:left = l:modestr . l:filepath
    let l:right = l:fileenc . '  ' . l:linecol . l:coc_status
    let l:ret = l:left . '%#UniStatusBg#%=' . l:right
    return l:ret
endfunction

" Set status line generator
set statusline=%!UnifiedGensl()


" Keybindings
" ===========

" Simple single character movement up and down.
" For left and right cursor movement better use neo's LIAE-direction-keys
noremap n j
noremap r k
noremap t l

" Word movement
" Intuitive, because similar to neo's LIAE-keys
noremap i b
noremap I B
noremap e e
noremap E E

" Replace key
noremap l r
noremap L R

" Insert mode
" appending still is at "a"
noremap u i
noremap U I

" Undo
noremap v u
noremap V <C-R>

" Search
noremap j n
noremap J N

" Visual mode
noremap b v
noremap B V

function! ToggleSpellChecking()
    let &spell=!&spell
    if &spell
        echomsg "Spell checking on, PageUp and PageDown to cycle, \",sa\" add, \",s?\" suggest"
    else
        echomsg "Spell checking off"
    endif
endfunction

" Don't do spell checking
" set nospell

" Spelling language english
set spelllang=en_us

set spellsuggest=best,20

" Toggle spell checking
noremap <silent> <Leader>ss :call ToggleSpellChecking()<CR>

" Add do dictionary
noremap <Leader>sa zg

" List all suggested spell checkings
noremap <Leader>s? z=

" Set spelling language to german
noremap <Leader>sd :set spelllang=de_20<CR>

" Set spelling language to english
noremap <Leader>se :set spelllang=en_us<CR>

" Cycle through spell checker issues
noremap <PageUp> [s
noremap <PageDown> ]s

" Jump to the first relevant character instead
noremap 0 ^

" Move line up/down with Alt+n/r
noremap <M-n> mz:m+<cr>`z
noremap <M-r> mz:m-2<cr>`z
inoremap <M-n> <ESC>mz:m+<cr>`za
inoremap <M-r> <ESC>mz:m-2<cr>`za

" When you press L you can search and replace the selected text
vnoremap <silent> L :call VisualSelection()<CR>

function! VisualSelection() range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    call CmdLine("%s" . '/'. l:pattern . '/')
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Quick-Fix key
noremap <leader>f  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer            
command! -nargs=0 Format :call CocAction('format')  

" File control
" TODO: some other vim buffer shit

" Cycle through buffers
noremap <M-S-n> :bp<CR>
noremap <M-S-r> :bn<CR>
inoremap <M-S-n> <ESC>:bp<CR>
inoremap <M-S-r> <ESC>:bn<CR>

" Movement between windows
noremap <C-r> <C-W><UP>
noremap <C-n> <C-W><DOWN>
noremap <C-s> <C-W><LEFT>
noremap <C-t> <C-W><RIGHT>
inoremap <C-r> <ESC><C-W><UP>
inoremap <C-n> <ESC><C-W><DOWN>
inoremap <C-s> <ESC><C-W><LEFT>
inoremap <C-t> <ESC><C-W><RIGHT>
noremap <C-UP> <C-W><UP>
noremap <C-DOWN> <C-W><DOWN>
noremap <C-LEFT> <C-W><LEFT>
noremap <C-RIGHT> <C-W><RIGHT>
inoremap <C-UP> <ESC><C-W><UP>
inoremap <C-DOWN> <ESC><C-W><DOWN>
inoremap <C-LEFT> <ESC><C-W><LEFT>
inoremap <C-RIGHT> <ESC><C-W><RIGHT>

" Strange functions that better nobody should ever see
" ====================================================

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()         
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")                
    let l:alternateBufNum = bufnr("#")                                                                  
    if buflisted(l:alternateBufNum)
        buffer #                                    
    else
        bnext                                       
endif
    if bufnr("%") == l:currentBufNum                
        new
    endif                                           
    if buflisted(l:currentBufNum)                   
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction                                         
