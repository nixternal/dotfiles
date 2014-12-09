" .vimrc
" Author: Rich Johnson <nixternal@gmail.com>
" Source: https://github.com/nixternal/dotfiles

" -----------------------------------------------------------------------------
" PATHOGEN & PRE-OPTIONS
" -----------------------------------------------------------------------------
"filetype off
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on                   " load indent file for filetype
set nocompatible                            " don't be compatible with vi
syntax on                                   " enable syntax highlighting
" -----------------------------------------------------------------------------
" BASIC OPTIONS
" -----------------------------------------------------------------------------
set autoindent
set background=dark                         " use colors for a dark background
set backspace=2                             " backspace over anything
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview
set confirm                                 " Y-N-C prompt if closing w/changes
set encoding=utf-8                          " set VIM lang to UTF-8
set expandtab
set foldlevelstart=99                       " all folds open by default
set foldmethod=syntax                       " use syntax to determine folds
set formatoptions-=tc                       " I can format for myself
set grepprg=grep\ -nH\ $*                   " setup grep to always gen filename
set guitablabel=%N/\ %t\ %M                 " tab labels show filename w/o path
set history=100                             " 100 lines of history
set hlsearch                                " highlight matches to the search
set ignorecase                              " search is case insensitive
set incsearch                               " show best match so far
set laststatus=2                            " always show statusline
set lazyredraw                              " don't repaint when scripts running
let mapleader=","                           " change the leader to be a comma
set matchtime=2                             " for .2 seconds
set modeline                                " last lines in file set vim mode
set mousehide                               " hide mouse pointer while typing
set nocp                                    " enable features non-vi-compat
set noshowmode                              " hide the default mode text
set notimeout
set number                                  " show line numbers
set numberwidth=1                           " use 1 col + 1 space for numbers
set printoptions=header:0,duplex:long,paper:letter
set report=0                                " notify me when any lines changed
set ruler                                   " line numbers & column cursor on
set scrolloff=3                             " keep 3 lines below & above cursor
set shiftwidth=4                            " number of space to (auto)indent
set shortmess+=a                            " use [+]/[RO]/[W] for mod/ro/mod
set showcmd                                 " display command waiting for op
set showfulltag                             " show more info when completing tag
set showmatch                               " briefly jump to prev match parent
set smartcase                               " search case sensitive if caps on
set softtabstop=4                           " 4 spaces as a tab for bs/del
set splitbelow                              " open horizontal split below
set splitright                              " open vertical split right
set synmaxcol=800                           " don't hilite lines longer than 800
set tabstop=4                               " number of space of tab char
set t_Co=256                                " 256 colors baby
set textwidth=80                            " 80 columns wide
set title                                   " show title in console title bar
set ttimeout
set ttimeoutlen=10
set ttyfast                                 " smoother changes
set vb t_vb=                                " disable visual bell
set wrapscan
" ------------------------------------------------------------------------------
" CUSTOM OPTIONS
" ------------------------------------------------------------------------------
" -- MyTodo - highlight TODO: FIXME: and XXX:
syn match MyTodo contained "\<\(TODO\FIXME\XXX\):)"
hi def link MyTodo Todo
" ------------------------------------------------------------------------------
" AUTO COMMANDS
" ------------------------------------------------------------------------------
if has("autocmd")
    augroup vimrcEx
        au!
        " text & svn wrap automatically
        au FileType text,svn setlocal tw=78 fo+=t
        " try to jump back to last spot cursor was in before exit
        au BufReadPost * if line("'\'")>0 && line("'\'")<=line("$")|exe "normal g`\""|endif
        " :make to check script w/ perl
        au FileType perl set makeprg=perl\ -c\ %\ $* errorformat=%f:%l:%m
        " :make to compile even w/o Makefile
        au FileType c,cpp if glob('Makefile') == ""|let &mp="gcc -o %< %"|endif
        " switch to dir of current file unless help file
        au BufEnter * if &ft!='help'|silent! cd %:p:h|endif
        " kill calltip window if cursor moved
        au CursorMovedI * if pumvisible()==0|pclose|endif
        " kill calltip window if insert mode left
        au InsertLeave * if pumvisible()==0|pclose|endif
    augroup END
endif
" -----------------------------------------------------------------------------
" WILDMENU COMPLETION
" -----------------------------------------------------------------------------
set wildmenu
set wildmode=longest,list
set wildignore+=.hg,.git,.svn                       " version control
set wildignore+=*.aux,*.out,*.toc                   " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg      " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest    " compiled object files
set wildignore+=*.spl                               " compiled spelling word lists
set wildignore+=*.sw?                               " vim swap files
set wildignore+=*.luac                              " Lua byte code
set wildignore+=migrations                          " Django migrations
set wildignore+=*.pyc                               " Python byte code
" ------------------------------------------------------------------------------
" PLUGINS
" ------------------------------------------------------------------------------
"
" -- Lightline
"
let g:lightline = {
    \ 'active': {
    \   'left': [['mode', 'paste'], ['fugitive', 'filename']],
    \   'right': [['syntastic', 'lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype']]
    \ },
    \ 'component_function': {
    \   'fugitive': 'MyFugitive',
    \   'filename': 'MyFilename',
    \   'fileformat': 'MyFileformat',
    \   'filetype': 'MyFiletype',
    \   'fileencoding': 'MyFileencoding',
    \   'mode': 'MyMode',
    \   'readonly': 'MyReadonly',
    \ },
    \ 'component_expand': {
    \   'syntastic': 'SyntasticStatuslineFlag',
    \ },
    \ 'component_type': {
    \   'syntastic': 'error',
    \ },
    \ 'separator': {'left': '', 'right': ''},
    \ 'subseparator': {'left': '', 'right': ''}
    \ }
function! MyModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! MyReadonly()
    return &ft !~? 'help' && &readonly ? '' : ''
endfunction
function! MyFilename()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
function! MyFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && exists('*fugitive#head')
            let mark = ''
            let _ = fugitive#head()
            return strlen(_) ? mark._ : ''
        endif
    catch
    endtry
    return ''
endfunction
function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction
function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction
function! MyMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
                \ fname == 'NERD_tree' ? 'NERDTree' :
                \ &ft == 'unite' ? 'Unite' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
let g:tagbar_status_func = 'TagbarStatusFunc'
function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
endfunction
let g:unite_force_overwrite_statusline = 0
"
" --WM Graphviz
"
nmap <silent> <Leader>li :GraphvizInteractive<CR>
nmap <silent> <Leader>ll :GraphvizCompile<CR>
"
" --JavaScript Libraries Syntax
"
let g:used_javascript_libs='jquery'
"
" --NERDTree
"
let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '\.class$', '\.pdf$']
map <leader>n :NERDTreeToggle<CR>
"
" --Syntastic
"
let g:syntastic_php_phpcs_args="--standard=WordPress"
"
" --SyntaxComplete
"
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
        \   if &omnifunc == "" |
        \       setlocal omnifunc=syntaxcomplete#Complete |
        \   endif
endif
"
" --Tagbar
"
nmap <silent> <leader>tt :TagbarToggle<CR>
"
" --UtilSnips
"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnips"]
let g:UltiSnipsUsePythonVersion=2
let g:UltiSnipsEditSplit="horizontal"
" ------------------------------------------------------------------------------
"  INDENTATION
" ------------------------------------------------------------------------------
autocmd FileType javascript,html,css,php,yaml,less set ai
autocmd FileType javascript,html,css,php,yaml,less set sw=2
autocmd FileType javascript,html,css,php,yaml,less set ts=2
autocmd FileType javascript,html,css,php,yaml,less set sts=2
" ------------------------------------------------------------------------------
" LANGUAGE SETTINGS
" ------------------------------------------------------------------------------
" --Re-detect on write
autocmd BufWritePost * if ! &filetype | :filetype detect | endif
" --C/C++
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType cpp setlocal omnifunc=cppcomplete#CompleteCPP
" --CSS
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" --HTML
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" --LaTeX
let g:tex_flavor='latex'
let g:Tex_ViewRule_pdf='/usr/bin/okular'
" --PHP
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType php let php_sql_query=1
autocmd FileType php let php_htmlInStrings=1
autocmd FileType php let php_noShortTags=1
autocmd FileType php DoMatchParen
" --Python
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" --XML
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" ------------------------------------------------------------------------------
" SPELL CHECKING
" ------------------------------------------------------------------------------
set spell
set spell spelllang=en_us
set spellfile =~/.vim/dict/dict.add
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1
highlight SpellBad term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline
" ------------------------------------------------------------------------------
" MAPPINGS
" ------------------------------------------------------------------------------
nmap <Leader>c :copen<CR>
nmap <Leader>cc :cclose<CR>
nmap <silent> <Leader>bdw :write<CR>:bdelete<CR>
cmap w!! w !sudo tee % >/dev/null
map <silent><A-Right> :tabnext<CR>
map <silent><A-Left> :tabprevious<CR>
map <Leader>v :sp ~/.vimrc<CR><C-W>_
map <silent> <Leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
"nnoremap <SID>I_WONT_EVER_TYPE_THIS <Plug>IMAP_JumpForward
"nmap <C-j> <C-w>j
"nmap <C-k> <C-w>k
"nmap <C-h> <C-w>h
"nmap <C-l> <C-w>l
nmap <S-j> <C-w>j
nmap <S-k> <C-w>k
nmap <S-h> <C-w>h
nmap <S-l> <C-w>l
