" Vim indent file
" Language   : Scala (http://scala-lang.org/)
" Maintainer : Stefan Matthias Aust
" Last Change: 2011 Feb 12 (Derek Wyatt)

"if exists("b:did_indent")
"  finish
"endif
"let b:did_indent = 1

setlocal indentexpr=GetScalaIndent()
setlocal indentkeys=0{,0},0),!^F,<>>,o,O,<CR>
setlocal autoindent

"if exists("*GetScalaIndent")
"    finish
"endif

function! CountParens(line)
    let line = substitute(a:line, '"\(.\|\\"\)*"', '', 'g')
    let open = substitute(line, '[^(]', '', 'g')
    let close = substitute(line, '[^)]', '', 'g')
    return strlen(open) - strlen(close)
endfunction

function! LineCompletesBrackets()
    let savedpos = getpos('.')
    let offline = 0
    while offline == 0
        let [lnum, colnum] = searchpos(')', 'Wb')
        let [lnumA, colnumA] = searchpairpos('(', '', ')', 'Wbn')
        if lnum != lnumA
            let [lnumB, colnumB] = searchpairpos('(', '', ')', 'Wbnr')
            let offline = 1
        endif
    endwhile
    call setpos('.', savedpos)
    if lnumA == lnumB && colnumA == colnumB
        return lnumA
    else
        return -1
    endif
endfunction

function! GetScalaIndent()
    " Find a non-blank line above the current line.
    let lnum = prevnonblank(v:lnum - 1)

    " Hit the start of the file, use zero indent.
    if lnum == 0
        return 0
    endif

    let ind = indent(lnum)
    let prevline = getline(lnum)

    " If this line starts with a { then make it indent the same as the previous line
    let curline = getline(v:lnum)
    if curline =~ '^\s*{'
        " Unless, of course, the previous one is a { as well
        if prevline !~ '^\s*{'
            return indent(lnum)
        endif
    endif

    " Indent html literals
    if prevline !~ '/>\s*$' && prevline =~ '^\s*<[a-zA-Z][^>]*>\s*$'
        return ind + &shiftwidth
    endif

    " Add a 'shiftwidth' after lines that start a block
    " If 'if', 'for' or 'while' end with ), this is a one-line block
    " If 'val', 'var', 'def' end with =, this is a one-line block
    let inOneLineBlock = 0
    if prevline =~ '^\s*\<\(\(else\s\+\)\?if\|for\|while\|va[lr]\|def\)\>.*[)=]\s*$'
                \ || prevline =~ '^\s*\<else\>\s*$'
                \ || prevline =~ '[{=]\s*$'
        let ind = ind + &shiftwidth
        let inOneLineBlock = 1
    endif

    " If parenthesis are unbalanced, indent or dedent
    let c = CountParens(prevline)
    if c > 0
        let ind = ind + &shiftwidth
    elseif c < 0
        " if the closing brace actually completes the braces entirely, then we
        " have to indent to line that started the whole thing
        let completeLine = LineCompletesBrackets()
        if completeLine == -1
            let ind = ind - &shiftwidth
        else
            let prevCompleteLine = getline(prevnonblank(completeLine - 1))
            " However, what actually started this part looks like it was a function
            " definition, so we need to indent to that line instead.  This is 
            " actually pretty weak at the moment.
            if prevCompleteLine =~ '=\s*$'
                let ind = indent(prevnonblank(completeLine - 1))
            else
                let ind = indent(completeLine)
            endif
        endif
    endif

    " Dedent after if, for, while and val, var, def without block
    let pprevline = getline(prevnonblank(lnum - 1))
    if pprevline =~ '^\s*\<\(\(else\s\+\)\?if\|for\|while\|va[lr]\|def\)\>.*[)=]\s*$'
                \ || pprevline =~ '^\s*\<else\>\s*$'
        " Unless we are already in a one line block.  If that's the case, then
        " we don't want to dedent since we've already got the right indent level
        if inOneLineBlock == 0
            let ind = ind - &shiftwidth
        endif
    endif

    " Align 'for' clauses nicely
    if prevline =~ '^\s*\<for\> (.*;\s*$'
        let ind = indent(lnum) + 5
    endif

    " Subtract a 'shiftwidth' on '}' or html
    let thisline = getline(v:lnum)
    if thisline =~ '^\s*[})]' || thisline =~ '^\s*</[a-zA-Z][^>]*>'
        let ind = ind - &shiftwidth
    endif

    return ind
endfunction
