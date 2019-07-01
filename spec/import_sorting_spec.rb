require_relative './spec_helper'

describe :SortScalaImports do
  each_fixture('sort_imports') do |fixture|
    it %'will sort imports in file #{fixture}' do
      actual = sort_fixture_across_groups(fixture)
      actual.must_equal expected(fixture)
    end
  end
end

def sort_fixture_across_groups(fixture_name)
  with_fixture(fixture_name) do |temp_file|
    # A global variable changes in each session,
    # so start a new vim each time.
    start_vim do |vim|
      vim.edit temp_file.path
      vim.command 'let g:scala_sort_across_groups=1'
      vim.command 'SortScalaImports'
      vim.write
    end
  end
end
