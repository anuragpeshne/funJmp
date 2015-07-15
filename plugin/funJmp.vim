function! s:jmpToFunction(name, patterns)
    if len(a:patterns) == 0
        echom "Unable to find '" . a:name . "'"
    else
        try
            execute "normal! /" .
                    \a:patterns[0]["prefix"] .
                    \'\<'  . a:name . '\>' .
                    \a:patterns[0]["suffix"] .
                    \"\<cr>"

            execute "normal! ^"
            echom "Found '" . a:name . "'"
        catch /E486:/
            " if pattern is not found then make a recursive call
            call s:jmpToFunction(a:name, a:patterns[1:])
        catch
            echom v:exception
        endtry
    endif
endfunction

function! GotoFunctionDef()
    let languagePattern = {
        \"c": [{'prefix': '^\w\+\s\+', 'suffix': '(.*)[^;]', }],
        \"javascript": [
            \{'prefix': 'function\s*', 'suffix': '\s*(', },
            \{'prefix': '', 'suffix': '\s*=\s*function', }
        \],
        \"php": [{'prefix': 'function\s*', 'suffix': '\s*(', }],
        \"java": [{'prefix': '', 'suffix': '\s*(.*)', }],
        \"python": [{'prefix': 'def\s*', 'suffix': '\s*(.*)\s*:', }]
    \}

    execute "normal! \"tyiw"
    let functionName = getreg("t")
    call s:jmpToFunction(functionName, languagePattern[&filetype])
endfunction

:nnoremap ∂ :call GotoFunctionDef()<cr>
" mapping <alt+d> on mac, which translates to ∂.
" If you are on non mac machine, you may need to change this
