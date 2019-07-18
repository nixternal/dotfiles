" autoload/my/project.vim - Query project metadata from multiple sources
" Copied from Noah Frederick - https://github.com/noahfrederick/dots
"
" Common keys to query:
" - title
" - author
" - email
" - license
" - copyright
" - github

function! s:git_config_get(key) abort
    let dir = exists(":Git") == 2 ? fugitive#repo().dir() : $HOME
    let cd = exists('*haslocaldir') && haslocaldir() ? 'lcd' : 'cd'
    let cwd = getcwd()

    execute cd fnameescape(dir)
    let result = system("git config --get " . a:key)[0:-2]
    execute cd fnameescape(cwd)

    return result
endfunction

let s:strategies = {}

function! s:strategies.git(key) abort
    if !executable("git")
        return ""
    endif

    let key = a:key
    let value = s:git_config_get("project." . key)

    if value == ""
        if key == "author"
            let key = "name"
        endif

        let value = s:git_config_get("user." . key)
    endif

    return value
endfunction

function! s:try_all_strategies(key) abort
    for name in ['git']
        let Strat = s:strategies[name]
        let value = call(Strat, [a:key], {})

        if value != ""
            return value
        endif
    endfor

    return ""
endfunction

" Query current buffer's project metadata by key.
function! my#project#get(key, ...) abort
    let default = get(a:000, 0, "[project-" . a:key . "]")
    let value = s:try_all_strategies(a:key)

    if value ==# "" && a:key ==# "copyright"
        let value = join(["©", strftime("%Y"), s:try_all_strategies("author")])
    endif

    return value ==# "" ? default : value
endfunction

" Get current buffer's project's root directory.
function! my#project#root() abort
    if exists("b:git_dir") && !empty(b:git_dir)
        return fnamemodify(b:git_dir, ":h")
    endif

    return getcwd()
endfunction
