function! s:phpFunction(name)
    try
        execute "normal! /function\\s*\\<" . a:name . "\\>(\<cr>"
        echom "Found " . a:functionName
    catch /E486:/
        echom "Unable to find " . a:name
    catch
        echom "unknown error"
    endtry
endfunction

function! s:JavaScriptFunction(functionName)
    try
        execute "normal! /function\\s*\\<" . a:functionName . "\\>(\<cr>"
    catch /E486:/
        try
            execute "normal! /\\<" . a:functionName . "\\>\\s*=\\s*function\<cr>"
            execute "normal! 0"
            echom "Found " . a:functionName
        catch /E486:/
            echom "Unable to find " . a:functionName
        catch
            echom "unknown error"
        endtry
    catch
        echom "unknown error"
    endtry
endfunction

function! s:cFunction(functionName)
    try
        execute "normal! /^\\w\\+\\s\\+\\<" . a:functionName . "\\>(.*)[^;]\<cr>"
        echom "Found " . a:functionName
    catch /E486:/
        echom "Unable to find " . a:name
    catch
        echom "unknown error"
    endtry
endfunction

function! GotoFunctionDef()
    execute 'normal! "tyiw'
    let functionName = getreg('t')
    if &filetype == 'php'
        call s:phpFunction(functionName)
    elseif &filetype == 'javascript'
        call s:JavaScriptFunction(functionName)
    elseif &filetype == 'c'
        call s:cFunction(functionName)
    endif
endfunction

:nnoremap ∂ :call GotoFunctionDef()<cr>
" mapping <alt+d> on mac, which translates to ∂.
" If you are on non mac machine, you may need to change this
