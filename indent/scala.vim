" Vim indent file
" Language   : Scala (http://scala-lang.org/)
" Maintainer : Stefan Matthias Aust
" Last Change: 2011 Mar 04 (Derek Wyatt)

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

function! scala#GetLine(lnum)
  let line = substitute(getline(a:lnum), '//.*$', '', '')
  let line = substitute(line, '"[^"]*"', '""', 'g')
  return line
endfunction

function! scala#CountBrackets(line, openBracket, closedBracket)
  let line = substitute(a:line, '"\(.\|\\"\)*"', '', 'g')
  let open = substitute(line, '[^' . a:openBracket . ']', '', 'g')
  let close = substitute(line, '[^' . a:closedBracket . ']', '', 'g')
  return strlen(open) - strlen(close)
endfunction

function! scala#CountParens(line)
  return scala#CountBrackets(a:line, '(', ')')
endfunction

function! scala#CountCurlies(line)
  return scala#CountBrackets(a:line, '{', '}')
endfunction

function! scala#ConditionalConfirm(msg)
  if 0
    call confirm(a:msg)
  endif
endfunction

function! scala#GetLineThatMatchesBracket(openBracket, closedBracket)
  let savedpos = getpos('.')
  call setpos('.', [savedpos[0], savedpos[1], 9999, savedpos[3]])
  call searchpos(a:closedBracket, 'Wb')
  let [lnum, colnum] = searchpairpos(a:openBracket, '', a:closedBracket, 'Wbn')
  call setpos('.', savedpos)
  return lnum
endfunction

function! scala#LineCompletesBrackets(openBracket, closedBracket)
  let savedpos = getpos('.')
  let offline = 0
  while offline == 0
    let [lnum, colnum] = searchpos(a:closedBracket, 'Wb')
    let [lnumA, colnumA] = searchpairpos(a:openBracket, '', a:closedBracket, 'Wbn')
    if lnum != lnumA
      let [lnumB, colnumB] = searchpairpos(a:openBracket, '', a:closedBracket, 'Wbnr')
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
  let prevline = scala#GetLine(lnum)
  call scala#ConditionalConfirm("computed indent is: " . ind)

  " If this line starts with a { then make it indent the same as the previous line
  let curline = scala#GetLine(v:lnum)
  if curline =~ '^\s*{'
    call scala#ConditionalConfirm("1")
    " Unless, of course, the previous one is a { as well
    if prevline !~ '^\s*{'
      call scala#ConditionalConfirm("2")
      return indent(lnum)
    endif
  endif

  " Indent html literals
  if prevline !~ '/>\s*$' && prevline =~ '^\s*<[a-zA-Z][^>]*>\s*$'
    call scala#ConditionalConfirm("3")
    return ind + &shiftwidth
  endif

  " Add a 'shiftwidth' after lines that start a block
  " If 'if', 'for' or 'while' end with ), this is a one-line block
  " If 'val', 'var', 'def' end with =, this is a one-line block
  let inOneLineBlock = 0
  if prevline =~ '^\s*\<\(\(else\s\+\)\?if\|for\|while\)\>.*[)=]\s*$'
        \ || prevline =~ '^\s*\<def\>.*[)=]\s*$'
        \ || prevline =~ '^\s*\<va[lr]\>.*[=]\s*$'
        \ || prevline =~ '^\s*\<else\>\s*$'
        \ || prevline =~ '=\s*$'
    call scala#ConditionalConfirm("4")
    let ind = ind + &shiftwidth
    let inOneLineBlock = 1
  endif

  for bracketType in [ ['(', ')'], ['{', '}'] ]
    let bracketCount = scala#CountBrackets(prevline, bracketType[0], bracketType[1])
    if bracketCount > 0 || prevline =~ '.*{\s*$' || prevline =~ '.*(\s*$'
      call scala#ConditionalConfirm("5")
      let ind = ind + &shiftwidth
      break
    elseif bracketCount < 0
      call scala#ConditionalConfirm("6")
      " if the closing brace actually completes the braces entirely, then we
      " have to indent to line that started the whole thing
      let completeLine = scala#LineCompletesBrackets(bracketType[0], bracketType[1])
      if completeLine != -1
        call scala#ConditionalConfirm("8")
        let prevCompleteLine = scala#GetLine(prevnonblank(completeLine - 1))
        " However, what actually started this part looks like it was a function
        " definition, so we need to indent to that line instead.  This is 
        " actually pretty weak at the moment.
        if prevCompleteLine =~ '=\s*$'
          call scala#ConditionalConfirm("9")
          let ind = indent(prevnonblank(completeLine - 1))
        else
          call scala#ConditionalConfirm("10")
          let ind = indent(completeLine)
        endif
      endif
      break
    endif
  endfor

  if curline =~ '^\s*}\s*else\s*{\s*$'
    let ind = ind - &shiftwidth
  endif

  " Subtract a 'shiftwidth' on '}' or html
  let curCurlyCount = scala#CountCurlies(curline)
  if curCurlyCount < 0
    call scala#ConditionalConfirm("14a")
    let matchline = scala#GetLineThatMatchesBracket('{', '}')
    return indent(matchline)
  elseif curline =~ '^\s*</[a-zA-Z][^>]*>'
    call scala#ConditionalConfirm("14c")
    let ind = ind - &shiftwidth
  endif

  let prevParenCount = scala#CountParens(prevline)
  if prevline =~ '^\s*\<for\>.*$' && prevParenCount > 0
    call scala#ConditionalConfirm("15")
    let ind = indent(lnum) + 5
  endif

  let prevCurlyCount = scala#CountCurlies(prevline)
  if prevCurlyCount == 0 && prevline =~ '^.*=>\s*$'
    call scala#ConditionalConfirm("16")
    let ind = ind + &shiftwidth
  endif

  call scala#ConditionalConfirm("returning " . ind)

  return ind
endfunction
