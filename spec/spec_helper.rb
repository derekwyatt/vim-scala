require 'vimrunner'
require 'tempfile'
require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'

PWD = File.expand_path('..', __FILE__)

def start_vim_without_plugins
  Vimrunner.start do |vim|
    vim.command 'filetype on'
    vim.command 'set verbose=2'

    # Prepend our local path to ensure the built-in scala code is not used.
    vim.prepend_runtimepath(File.expand_path('../..', __FILE__))
    # puts 'vimrunner runtimepath:', vim.echo('&runtimepath')

    plugin_loader = lambda do
      vim.command 'runtime! ftdetect/scala.vim'
      vim.command 'runtime! ftplugin/scala.vim'
      vim.command 'runtime! ftplugin/scala/tagbar.vim'
      vim.command 'runtime! indent/scala.vim'
      vim.command 'runtime! plugin/scala.vim'
      vim.command 'runtime! syntax/scala.vim'
      vim.command 'runtime! compiler/scala.vim'
      vim.command 'runtime! after/syntax/scala.vim'
    end

    yield vim, plugin_loader
  end
end

def start_vim
  start_vim_without_plugins do |vim, plugin_loader|
    plugin_loader.call
    yield vim
  end
end

def with_temp_file(source_filename)
  temp_file = Tempfile.new('vim-scala-testing-')
  begin
    temp_file.write File.read(source_filename)
    temp_file.rewind

    yield temp_file

    temp_file.rewind
    temp_file.read
  ensure
    temp_file.close
    temp_file.unlink
  end
end

def with_fixture(fixture_name, &block)
  with_temp_file fixture_path(fixture_name), &block
end

def each_fixture(dir)
  Dir.each_child(File.join(PWD, 'fixtures', dir)) do |child|
    next if child.end_with? '.expected.scala'
    yield File.join(dir, child)
  end
end

def fixture_path(filename)
  %'#{PWD}/fixtures/#{filename}'
end

def expected(filename)
  File.read fixture_path filename.gsub(/scala$/, 'expected.scala')
end

