" Requirements
" ============

"  * nvim
"  * ctags
"  * vim-plug
"  	install it by moving `https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
"  	to `$HOME/.local/share/nvim/site/autoload/plug.vim`
"  	and then execute `:PlugInstall`
"  * coc-yank
"       after executing `:PlugInstall`, do `:CocInstall coc-yank


" Basic Configuration
" ===================

" Do not try to act like VI
" Enable more modern features that might be confusing for vi users
set nocompatible

" Enable syntax and plugins (for netrw)
syntax enable
filetype plugin on

" Enable automatic indents
set autoindent

" Backspacing in insert mode behaves as one would expect
set backspace=indent,eol,start

" On <Tab> insert blanks according to 'shiftwidth'
set smarttab

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
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/target/*

" Fuzzy finding
" =============

" Enable recursive searching with find
"   :find - can now fuzzy-find
set path+=**

" Enable tab-completion for fuzzy-find
set wildmenu
set wildchar=<Tab>


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

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" TODO: Consider some plugins by tpope
" TODO: NerdTree?
" TODO: status line plugins?

call plug#end()

" Plugins
" =======

" coc-yank
" --------
" > see coc-settings.json
hi HighlightedyankRegion term=bold ctermbg=4 guibg=#13354A

" Mouse focus
" ===========

" Enable mouse navigation for all modes except for prompts
set mouse=a

" When typing hide mouse (only works in gui)
set mousehide=on

" Keybindings
" ===========

" Simple single character movement up and down.
" For left and right cursor movement better use neo's LIAE-direction-keys
noremap n j
noremap r k

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

" File control
" TODO: some other vim buffer shit

" Cycle through buffers
noremap <C-n> :bp<CR>
noremap <C-r> :bn<CR>
inoremap <C-n> <ESC>:bp<CR>
inoremap <C-r> <ESC>:bn<CR>

" Movement between windows
noremap <C-UP> <C-W><UP>
noremap <C-DOWN> <C-W><UP>
nnoremap <C-UP> <C-W><UP>
nnoremap <C-UP> <C-W><UP>
