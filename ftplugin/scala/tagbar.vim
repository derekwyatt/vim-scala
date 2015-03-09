"
" Support for Tagbar -- https://github.com/majutsushi/tagbar
"
" Hat tip to Leonard Ehrenfried for the built-in ctags deffile:
"    https://leonard.io/blog/2013/04/editing-scala-with-vim/
"
if !exists(':Tagbar')
  finish
endif

let g:tagbar_type_scala = {
    \ 'ctagstype' : 'scala',
    \ 'kinds'     : [
      \ 'p:packages',
      \ 'V:values',
      \ 'v:variables',
      \ 'T:types',
      \ 't:traits',
      \ 'o:objects',
      \ 'O:cobjects',
      \ 'c:classes',
      \ 'C:cclasses',
      \ 'm:methods:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'p' : 'package',
        \ 'T' : 'type',
        \ 't' : 'trait',
        \ 'o' : 'object',
        \ 'O' : 'case_object',
        \ 'c' : 'class',
        \ 'C' : 'case_class',
        \ 'm' : 'method'
    \ },
    \ 'scope2kind' : {
      \ 'package' : 'p',
      \ 'type' : 'T',
      \ 'trait' : 't',
      \ 'object' : 'o',
      \ 'case_object' : 'O',
      \ 'class' : 'c',
      \ 'case_class' : 'C',
      \ 'method' : 'm'
    \ }
\ }

" In case you've updated/customized your ~/.ctags and prefer to use it.
if get(g:, 'scala_use_builtin_tagbar_defs', 1)
  let g:tagbar_type_scala.deffile = expand('<sfile>:p:h:h:h') . '/ctags/scala.ctags'
endif

"
" sctags gives much better results (scopes, etc) but is slower
" https://github.com/luben/sctags
"
if executable("sctags")
  let g:tagbar_ctags_bin = "sctags"
endif
