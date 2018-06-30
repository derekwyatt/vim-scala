require_relative './spec_helper'

# This test simulates what happens in plugin/matchparen.vim, to ensure syntax/scala.vim
# uses style names that use the correct magic words.

describe 'default matching behavior' do
  it 'jumps over parentheses in single-quotes' do
    with_fixture('misc/jump_to_matching_paren.scala') do |file|
      start_vim do |vim|
        vim.edit file.path
        vim.command 'set ft=scala'
        vim.normal '2gg'
        vim.normal '6|'
        line_num, col_num = searchpairpos(vim, '(', '', ')', 'nW')

        line_num.must_equal '2'
        col_num.must_equal '10'

        vim.normal '3gg'
        vim.normal '10|'
        line_num, col_num = searchpairpos(vim, '(', '', ')', 'bnW')

        line_num.must_equal '3'
        col_num.must_equal '6'
      end
    end
  end

  it 'jumps over curly braces in single-quotes' do
    with_fixture('misc/jump_to_matching_curly.scala') do |file|
      start_vim do |vim|
        vim.edit file.path
        vim.command 'set ft=scala'
        vim.normal '1gg'
        vim.normal '13|'
        line_num, col_num = searchpairpos(vim, '{', '', '}', 'nW')

        line_num.must_equal '4'
        col_num.must_equal '1'

        vim.normal '4gg'
        vim.normal '1|'
        line_num, col_num = searchpairpos(vim, '{', '', '}', 'bnW')

        line_num.must_equal '1'
        col_num.must_equal '13'
      end
    end
  end
end

def read_pair(str)
  str.match(/\[(\d+), (\d+)\]/)[1, 2]
end

def searchpairpos(vim, head, middle, tail, flags)
  # distilled from vim80/plugin/matchparen.vim.
  expr = <<-EXPR
  searchpairpos('#{head}', '#{middle}', '#{tail}', '#{flags}', 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string\\\\|character\\\\|singlequote\\\\|escape\\\\|comment"')
  EXPR

  read_pair vim.echo expr
end

