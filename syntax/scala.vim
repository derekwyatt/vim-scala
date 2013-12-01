if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let b:current_syntax = "scala"

syn case match
syn sync minlines=200 maxlines=1000

syn keyword scalaKeyword catch do else final finally for forSome if
syn keyword scalaKeyword match return throw try while yield
syn keyword scalaKeyword class trait object extends with type nextgroup=scalaInstanceDeclaration skipwhite
syn keyword scalaKeyword case nextgroup=scalaCaseFollowing skipwhite
syn keyword scalaKeyword val nextgroup=scalaNameDefinition,scalaQuasiQuotes skipwhite
syn keyword scalaKeyword def var nextgroup=scalaNameDefinition skipwhite
hi link scalaKeyword Keyword

syn match scalaNameDefinition /\<[A-Za-z0-9$]\+\>/ contained
hi link scalaNameDefinition Normal

syn match scalaInstanceDeclaration /\<[A-Za-z0-9$]\+\>/ contained
hi link scalaInstanceDeclaration Special

syn match scalaCaseFollowing /\<[A-Z][A-Za-z0-9$]*\>/ contained
hi link scalaCaseFollowing Special

syn keyword scalaKeywordModifier abstract override final implicit lazy private protected sealed null require super
hi link scalaKeywordModifier Function

syn keyword scalaSpecial this new true false package import
syn match scalaSpecial "\%(=>\|<-\|->\)"
syn match scalaSpecial /package object/
hi link scalaSpecial PreProc

syn region scalaString start=/"/ skip=/\\"/ end=/"/
hi link scalaString String

syn region scalaSString matchgroup=PreProc start=/s"/ skip=/\\"/ end=/"/ contains=scalaInterpolation
syn match scalaInterpolation /\$[a-zA-Z0-9$]\+/ contained
syn match scalaInterpolation /\${[^}]\+}/ contained
hi link scalaSString String
hi link scalaInterpolation Function

syn region scalaFString matchgroup=PreProc start=/f"/ skip=/\\"/ end=/"/ contains=scalaInterpolation,scalaFInterpolation
syn match scalaFInterpolation /\$[a-zA-Z0-9$]\+%[-A-Za-z0-9\.]\+/ contained
syn match scalaFInterpolation /\${[^}]\+}%[-A-Za-z0-9\.]\+/ contained
hi link scalaFString String
hi link scalaFInterpolation Function

syn region scalaQuasiQuotes matchgroup=Type start=/\<q"/ skip=/\\"/ end=/"/ contains=scalaInterpolation
syn region scalaQuasiQuotes matchgroup=Type start=/\<[tcp]q"/ skip=/\\"/ end=/"/ contains=scalaInterpolation
hi link scalaQuasiQuotes String

syn region scalaTripleQuasiQuotes matchgroup=Type start=/\<q"""/ end=/"""/ contains=scalaInterpolation
syn region scalaTripleQuasiQuotes matchgroup=Type start=/\<[tcp]q"""/ end=/"""/ contains=scalaInterpolation
hi link scalaTripleQuasiQuotes String

syn region scalaTripleString start=/"""/ end=/"""/
syn region scalaTripleSString matchgroup=PreProc start=/s"""/ end=/"""/
syn region scalaTripleFString matchgroup=PreProc start=/f"""/ end=/"""/
hi link scalaTripleString String
hi link scalaTripleSString String
hi link scalaTripleFString String

syn match scalaNumber /\<[1-9]\d*[dDfFlL]\?\>/ containedin=ALL,scalaInterpolation,scalaFInterpolation
syn match scalaNumber /\<0[xX][0-9a-fA-F]\+[dDfFlL]\?\>/ containedin=ALL,scalaInterpolation,scalaFInterpolation
syn match scalaNumber "\%(\<\d\+\.\d*\|\.\d\+\)\%([eE][-+]\=\d\+\)\=[fFdD]\=" containedin=ALL,scalaInterpolation,scalaFInterpolation
syn match scalaNumber "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>" containedin=ALL,scalaInterpolation,scalaFInterpolation
syn match scalaNumber "\<\d\+\%([eE][-+]\=\d\+\)\=[fFdD]\>" containedin=ALL,scalaInterpolation,scalaFInterpolation
hi link scalaNumber Number

syn region scalaSquareBrackets matchgroup=Type start="\[" end="\]" contains=scalaSpecial,scalaTypeParameter,scalaSquareBrackets,scalaTypeOperator
syn match scalaTypeAnnotation /\%(:\s*\)\@<=[A-Za-z0-9$]\+/
syn match scalaTypeParameter /[A-Za-z0-9$]\+/ contained
syn match scalaTypeOperator /[=:<>]\+/ contained
hi link scalaTypeAnnotation Type
hi link scalaTypeParameter Type
hi link scalaTypeOperator Type
