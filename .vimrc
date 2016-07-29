" ============================================================================
" Personal .vimrc by Beau Hoyt "
" ============================================================================

" Fix vim color with screen
set t_Co=256

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Prevents VIM from being nerfed into acting like VI
set nocompatible

" Better copy & paste
set pastetoggle=<F2>
set clipboard=unnamed

" Enable mouse
" on OSX press ALT and click
"" set mouse=a

" Enabled backspace
" make backspace behave like normal again
set bs=2

" Rebhind <Leader> key
let mapleader=','

" For numbers.vim bundle mappings
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>

" Bind nohl
" Remove highlight of your last search
" Ctrl+p to remove highlighting
noremap <C-p> :nohl<CR>
vnoremap <C-p> :nohl<CR>
inoremap <C-p> :nohl<CR>

" Quicksave command
" Ctrl+Z to save
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>

" Quick quit command
" ,+e will close out buffer
" ,+E will quit all files opened
noremap <Leader>e :quit<CR>
noremap <Leader>E :qa!<CR>

" Bind Ctrl + <movement> keys to move around the windows, instead of using
" Ctrl+W + <movement>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Easier mvoing between tabs
" ,+n will go to previous tab
" ,+m will go to next tab
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Map sort function to a key
" s will sort normally
" S will sort in reverse
vnoremap <Leader>s :sort<CR>
vnoremap <Leader>S :sort!<CR>

" Easier moving of code blocks
" So you don't lose your virtural select
" For better indentation
vnoremap < <gv
vnoremap > >gv

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256       " Set max colors to 256
color wombat256mod

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on

" Showing line numbers and length
set number " Show line numbers
set tw=79  " Width of document (used by gd)
set nowrap " Don't automatically wrap on load
set fo-=t  " Don't automatically wrap text when typing

" Display right margin column
" Set color of right display margin column
set colorcolumn=80
highlight ColorColumn ctermbg=233

" Easier formatting of paragraphs
" Q will reorder word within 80 character limit
vmap Q qq
nmap Q gqap

" Userful setting for history and number of undos
set history=750
set undolevels=750

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Yaml files need only two spaces to be pretty
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 shiftround expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable stupid backup and swap files
set nobackup
set nowritebackup
set noswapfile

" Setup Pathogen to manage plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder
call pathogen#infect()

" Settings for vim-powerline
" Vim powerline is a more beautiful info bar at the bottom of vim
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
" Not used anymore - refer to vim-airline
" set laststatus=2

" Settings for vim-airline
" Lean & mean status/tabline for vim that's light as air
" cd ~/.vim/bundle
" git submodule add -f git@github.com:bling/vim-airline.git
set laststatus=2
" Comment this out if you dont have the fonts intsalled from:
" https://github.com/Lokaltog/powerline-fonts
" let g:airline_powerline_fonts = 1

" Settings for ctrlp
" Control P is a full path fuzzy file, buffer, mru, tag, ... finder for Vim
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
" Ctrl+p will open control P
" Not used right now
" let g:ctrlp_max_height = 30
" set wildignore+=*.pyc

" Map <F8> to toggle the Tagbar window
nmap <F8> :TagbarToggle<CR>

" ============================================================================
" Go IDE Setup
" ============================================================================
" https://github.com/fatih/vim-go
"
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

" Or open the Godoc in browser
" au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

" Show a list of interfaces which is implemented by the type under your cursor
" with <leader>s
" au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-implements)

" Show type info for the word under your cursor with <leader>i (useful if you
" have disabled auto showing type info via g:go_auto_type_info)
" au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>I <Plug>(go-info)

" Rename the identifier under the cursor to a new name
au FileType go nmap <Leader>e <Plug>(go-rename)

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Enable goimports to automatically insert import paths instead of gofmt:
let g:go_fmt_command = "goimports"

" By default vim-go shows errors for the fmt command, to disable it:
" let g:go_fmt_fail_silently = 1

" Disable auto fmt on save:
" let g:go_fmt_autosave = 0

" Disable opening browser after posting your snippet to play.golang.org:
" let g:go_play_open_browser = 0

" All commands support collecting and displaying errors in Vim's location list.
"
" Quickly navigate through these location lists with :lne for next error and
" :lp for previous. You can also bind these to keys, for example:
" map <C-n> :lne<CR>
" map <C-m> :lp<CR>

" Sometimes when using both vim-go and syntastic Vim will start lagging while
" saving and opening files. The following fixes this:
" let g:syntastic_go_checkers = ['golint', 'go vet', 'errcheck']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" let g:tagbar_type_go = {
"     \ 'ctagstype' : 'go',
"     \ 'kinds'     : [
"         \ 'p:package',
"         \ 'i:imports:1',
"         \ 'c:constants',
"         \ 'v:variables',
"         \ 't:types',
"         \ 'n:interfaces',
"         \ 'w:fields',
"         \ 'e:embedded',
"         \ 'm:methods',
"         \ 'r:constructor',
"         \ 'f:functions'
"     \ ],
"     \ 'sro' : '.',
"     \ 'kind2scope' : {
"         \ 't' : 'ctype',
"         \ 'n' : 'ntype'
"     \ },
"     \ 'scope2kind' : {
"         \ 'ctype' : 't',
"         \ 'ntype' : 'n'
"     \ },
"     \ 'ctagsbin'  : 'gotags',
"     \ 'ctagsargs' : '-sort -silent'
" \ }

" ============================================================================
" Python IDE Setup
" ============================================================================

" Settings for python-mode
" cd ~/.vim/bundle
" git clone https://github.com/klen/python-mode
map <Leader>g :call RopeGotoDefinition()<CR>
let ropevim_enable_shortcuts = 1
let g:pymode_rope_goto_def_newwin = "vnew"
let g:pymode_rope_extended_complete = 1
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
" j will map to ctrl+N
" k will map to ctrl+P
" set completeopt=longest,menuone
" function! OmniPopup(action)
"     if pumvisible()
"         if a:action == 'j'
"             return "\<C-N>"
"         elseif a:action == 'k'
"             return "\<C-P>"
"         endif
"     endif
"     return a:action
" endfunction
"
" inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
" inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
set nofoldenable
