" --[ Author Information                             ]{{{1
" .vimrc
" Author: Rich Johnson <nixternal@gmail.com>
" Source: https://github.com/nixternal/dotfiles

" --[ Vundle                                         ]{{{1
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle "VundleVim/Vundle.vim"
Bundle "itchyny/lightline.vim"
Bundle "Valloric/YouCompleteMe"
Bundle "scrooloose/syntastic"
Bundle "klen/python-mode"
Bundle "ap/vim-css-color"
Bundle "mattn/emmet-vim"
Bundle "majutsushi/tagbar"
Bundle "SirVer/ultisnips"
Bundle "Shougo/unite.vim"
Bundle "Valloric/MatchTagAlways"
Bundle "godlygeek/tabular"
Bundle "vim-latex/vim-latex"
Bundle "DavidGamba/vim-vmath"
Bundle "jelera/vim-javascript-syntax"
Bundle "pangloss/vim-javascript"
Bundle "hail2u/vim-css3-syntax"
Bundle "marijnh/tern_for_vim"
Bundle "groenewege/vim-less"
Bundle "Raimondi/delimitMate"
Bundle "Konfekt/FastFold"
call vundle#end()
filetype plugin indent on
syntax on

" --[ Basic Settings                                 ]{{{1
set autoindent
set background=dark                         " use colors for a dark background
set backspace=2                             " backspace over anything
set complete=.,w,b,u,t,i
set completeopt=longest,menuone,preview
set confirm                                 " Y-N-C prompt if closing w/changes
set encoding=utf-8
set expandtab
set foldlevelstart=0
set foldmethod=marker
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
set modelines=5                             " last lines in file set vim mode
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

" --[ Spell Checking                                 ]{{{1
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

" --[ Mappings                                       ]{{{1
nmap <Leader>c :copen<CR>
nmap <Leader>cc :cclose<CR>
map <Leader>v :sp ~/.vimrc<CR><C-W>_
map <silent> <Leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
nmap <S-j> <C-w>j
nmap <S-k> <C-w>k
nmap <S-h> <C-w>h
nmap <S-l> <C-w>l
" -- Use ; to access shift+:, just quicker
nnoremap ; :
" -- Blink my search results forward/backward
nnoremap <silent> n n:call HLNext(0.4)<cr>
nnoremap <silent> N N:call HLNext(0.4)<cr>
" -- VMath
vmap <expr> ++ VMATH_YankAndAnalyse()
nmap ++ vip++

" --[ Color Tweaks                                   ]{{{1
" -- Highlight TODO: FIXME and XXX:
syn match MyTodo contained "\<\(TODO\FIXME\XXX\):)"
hi def link MyTodo Todo
" -- Show where column is longer than 80 characters
highlight ColorColumn ctermbg=white ctermfg=red
call matchadd('ColorColumn', '\%81v', 100)
" -- Search results highlight to make it easier to see where I am
function! HLNext(blinktime)
    highlight WhiteOnRed ctermbg=red ctermfg=white
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let blinks = 3
    for n in range(1, blinks)
        let red = matchadd('WhiteOnRed', target_pat, 101)
        redraw
        exec 'sleep ' . float2nr(a:blinktime / (2 * blinks) * 1000) . 'm'
        call matchdelete(red)
        redraw
        exec 'sleep ' . float2nr(a:blinktime / (2 * blinks) * 1000) . 'm'
    endfor
endfunction

" --[ Wildmenu                                       ]{{{1
set wildmode=longest,list
set wildignore+=.hg,.git,.svn                       " version control
set wildignore+=*.aux,*.out,*.toc                   " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg      " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest    " compiled object files
set wildignore+=*.spl                               " compiled spelling lists
set wildignore+=*.sw?                               " vim swap files
set wildignore+=*.luac                              " Lua byte code
set wildignore+=migrations                          " Django migrations
set wildignore+=*.pyc                               " Python byte code

" --[ Auto Commands                                  ]{{{1
augroup vimrcEx
    au!
    " try to jump back to last spot cursor was before exit
    au BufReadPost * if line("'\'") >0 && line("'\'") <= line("$") | exe "normal g'\"" | endif
    " :make to check script w/ perl
    au FileType perl set makeprg=perl\ -c\ %\ $* errorformat=%f:%l:%m
    " :make to compile even w/o Makefile
    au FileType c,cpp if glob('Makefile') == "" | let &mp="gcc -o %< %" | endif
    " switch to directory of current file unless help file
    au BufEnter * if &ft != 'help' | silent! cd %:p:h | endif
    " kill calltip window if cursor moved
    au CursorMovedI * if pumvisible() == 0 | pclose | endif
    " kill calltip window if insert mode left
    au InsertLeave * if pumvisible() == 0 | pclose | endif
augroup END

" --[ Indentation                                    ]{{{1
" -- JavaScript, HTML, CSS, PHP, Yaml, LESS, SASS
au FileType css,html,javascript,json,less,php,sass,yaml setl ai sw=2 ts=2 sts=2

" -- LaTex
autocmd FileType tex set sw=2

" --[ Programming/Markup/Scripting Language Settings ]{{{1
" -- Re-detect filetype on write
autocmd BufWritePost * if ! &filetype | :filetype detect | endif

" -- LaTeX
let g:tex_flavor='latex'
let g:Tex_ViewRule_pdf='/usr/bin/okular'

" --[ PLUGIN: Lightline                              ]{{{1
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

" --[ PLUGIN: YouCompleteMe                          ]{{{1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_min_num_identifier_candidate_chars=4
let g:ycm_path_to_python_interpreter='/usr/bin/python'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_extra_conf_vim_data=['&filetype']

" --[ PLUGIN: UltiSnips                              ]{{{1
let g:UltiSnipsExpandTrigger='<C-space>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnips"]
let g:UltiSnipsEditSplit="horizontal"
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        call UltiSnips#JumpForwards()
        if g:ulti_jump_forwards_res == 0
            return ""
        endif
    endif
    return ""
endfunction
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

" --[ PLUGIN: Python-Mode                            ]{{{1
let g:pymode=1
let g:pymode_folding=1
let g:pymode_options_colorcolumn=0
let g:pymode_rope_complete_on_dot=0
au BufWriteCmd *.py write || :PymodeLint
augroup unset_folding_in_insert_mode
    autocmd!
    autocmd InsertEnter *.py setlocal foldmethod=marker
    autocmd InsertLeave *.py setlocal foldmethod=expr
augroup END

" --[ PLUGIN: Syntastic                              ]{{{1
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": [
        \ "c",
        \ "cpp",
        \ "python"
    \ ]
\ }
let g:syntastic_mode_map = { "mode": "active",
                           \ "active_filetypes": ["python"]}

" --[ PLUGIN: DelmitMate                             ]{{{1
function BreakLine()
    if (mode() == 'i')
        return ((getline(".")[col(".")-2] == '{' && getline(".")[col(".")-1] == '}') ||
              \ (getline(".")[col(".")-2] == '(' && getline(".")[col(".")-1] == ')'))
    else
        return 0
    endif
endfunction
inoremap <expr> <CR> BreakLine() ? "<CR><ESC>O" : "<CR>"

" --[ PLUGIN: CSS3 Syntaxt                           ]{{{1
highlight VendorPrefix ctermfg=51
match VendorPrefix /-\(moz\|webkit\|o\|ms\)-[a-zA-z]\+/

"}}}
