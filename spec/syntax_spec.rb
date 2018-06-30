require_relative './spec_helper'

describe 'syntax/scala.vim' do
  it 'allows the user to override scala-specific links' do
    start_vim_without_plugins do |vim, plugin_loader|
      # Set our custom value, then load the plugins.
      # This simulates vim loading .vimrc then later loading the filetype plugin.
      vim.command 'hi! CustomUserValue ctermfg=Red guifg=Red'
      vim.command 'hi! link scalaKeyword CustomUserValue'
      plugin_loader.call

      # 'verbose hi scalaKeyword' returns 'scalaKeyword xxx links to NNN'
      # That NNN should still be our custom value.
      keyword_linked_to = vim.command('verbose hi scalaKeyword').split[4]
      keyword_linked_to.must_equal "CustomUserValue"
    end
  end

  it 'allows the user to override scala-specific colors' do
    start_vim_without_plugins do |vim, plugin_loader|
      # Set our custom value, then load the plugins.
      # This simulates vim loading .vimrc then later loading the filetype plugin.
      vim.command 'hi! scalaKeyword ctermfg=123 guifg=123'
      plugin_loader.call

      keyword_fg_color = vim.echo('synIDattr(synIDtrans(hlID("scalaKeyword")), "fg")')
      keyword_fg_color.must_equal '123'
    end
  end
end
