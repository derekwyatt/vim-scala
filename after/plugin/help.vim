
function! FixTOCLine(beginning, colonCol)
    let l = strlen(a:beginning)
    let c = 0
    let dots = ""
    while c < (a:colonCol - l)
        let dots = dots . "."
        let c += 1
    endwhile
    return (a:beginning . dots . ":")
endfunction

function! BuildTOC()
    let lnum = getpos(".")[1]
    call append(lnum - 1, "<<<")
    call append(lnum, ">>>")
    :g/^\d\+\./co/>>>/-
    :g/^<<</,/^>>>/s/ {{{\d\s*//
    :g/^<<</,/^>>>/s/\*/|/g
    :g/^<<</,/^>>>/s/^\ze\d\.\d\+\./      /
    :g/^<<</,/^>>>/s/^\ze\d\d\.\d\+\./     /
    :g/^<<</,/^>>>/s/^\ze\d\.\d\+/    /
    :g/^<<</,/^>>>/s/^\ze\d\d\.\d\+/   /
    :g/^<<</,/^>>>/s/^\ze\d\./  /
    :g/^<<</,/^>>>/s/^\ze\d\d\./ /
    :g/^\s\+0\. Content/d
    :g/<<</+,/>>>/-s/^\(.\{-}\)\(\s\+\)\ze |/\=FixTOCLine(submatch(1), 45)/
    :g/<<</d
    :g/>>>/d
endfunction

command! BuildNewTableOfContents silent! call BuildTOC()

function! JustifyCurrentLine()
    let cline = getline('.')
    let matches = matchlist(cline, '^\(.*\)\s\+\(\*.*\)$')
    let st = matches[1]
    let fin = matches[2]
    let spcnum = 78 - strlen(st) - strlen(fin)
    let c = 0
    let spcs = ""
    while c < spcnum
        let spcs = spcs . " "
        let c = c + 1
    endwhile
    let newline = st . spcs . fin
    :norm dd
    let lnum = getpos('.')[1]
    call append(lnum - 1, newline)
endfunction

nmap ,jt :call JustifyCurrentLine()<cr>
