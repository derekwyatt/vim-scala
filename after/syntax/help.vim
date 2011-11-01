let b:current_syntax = ''
unlet b:current_syntax
syntax include @ScalaCode syntax/scala.vim
if has('conceal')
  syntax region rgnScala matchgroup=Ignore concealends start='!sc!' end='!/sc!' contains=@ScalaCode
endif
