fun! s:DetectScala()
  let s:line1 = getline(1)

  if s:line1 =~ "#!"
    " Check for a line like "#!/usr/bin/env VAR=val scala".  Turn it into
    " "#!/usr/bin/scala" to make matching easier.
    if s:line1 =~ '^#!\s*\S*\<env\s'
      let s:line1 = substitute(s:line1, '\S\+=\S\+', '', 'g')
      let s:line1 = substitute(s:line1, '\<env\s\+', '', '')
    endif

    " Get the program name.
    " Only accept spaces in PC style paths: "#!c:/program files/scala [args]".
    " If the word env is used, use the first word after the space:
    " "#!/usr/bin/env scala [path/args]"
    " If there is no path use the first word: "#!scala [path/args]".
    " Otherwise get the last word after a slash: "#!/usr/bin/scala [path/args]".
    if s:line1 =~ '^#!\s*\a:[/\\]'
      let s:name = substitute(s:line1, '^#!.*[/\\]\(\i\+\).*', '\1', '')
    elseif s:line1 =~ '^#!.*\<env\>'
      let s:name = substitute(s:line1, '^#!.*\<env\>\s\+\(\i\+\).*', '\1', '')
    elseif s:line1 =~ '^#!\s*[^/\\ ]*\>\([^/\\]\|$\)'
      let s:name = substitute(s:line1, '^#!\s*\([^/\\ ]*\>\).*', '\1', '')
    else
      let s:name = substitute(s:line1, '^#!\s*\S*[/\\]\(\i\+\).*', '\1', '')
    endif

    if s:name =~ 'scala'
      set filetype=scala
    endif

  endif
endfun

au BufRead,BufNewFile *.scala,*.sbt set filetype=scala
au BufRead,BufNewFile * call s:DetectScala()
