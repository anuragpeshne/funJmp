function! s:phpFunction(name)
    execute "silent! 1; normal! /function\\s*\\<" . a:name . "\\>(\<cr>"
endfunction

function! s:JavaScriptFunction(functionName)
    execute "silent! 1; normal! /function\\s*\\<" . a:functionName . "\\>(\<cr>"
    " to-do: check if search was successful
    " else try var functionName = function() {...
endfunction

function! s:cFunction(functionName)
    execute "silent! 1; normal! /\w+ \\<" . a:functionName . "\\>(\<cr>"
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
