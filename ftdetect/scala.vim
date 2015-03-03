" detecting scala scripts can be quite involved
" check this link for an example:
" http://www.scalaclass.com/node/10
" So we can have something as simple as
" #!/usr/bin/env scala
"
" or something more elaborate such as
" #!/bin/sh
" exec scala
" !#
"
" or even more complex
" #!/bin/sh
" L=`dirname $0`/../lib
" cp=`echo $L/*.jar|sed 's/ /:/g'`
" exec scala -classpath $cp $0 $@
" !#
"
" This will try to detect that. However, to prevent startup
" slowdowns, only the first 100 lines are checked
fun! s:DetectScala()
    let shebang = getline(1)
    if shebang =~# '^#!.*/bin/env\s\+scala\>' | return 1 | en
    if shebang =~# '^#!.*/bin/.*sh'
        let cur = 2
        let maxlines = min([100, line('$')])
        while cur <= maxlines
            let curline = getline(cur)
            if curline =~ '^exec\s\+scala' | return 1 | en
            if curline =~ '^!#' | break | en
            let cur = cur + 1
        endwhile
    endif
    return 0
endfun

au BufRead,BufNewFile *.scala set filetype=scala
au BufRead,BufNewFile * if s:DetectScala() | set filetype=scala | en

" Install vim-sbt for additional syntax highlighting.
au BufRead,BufNewFile *.sbt setfiletype sbt.scala
