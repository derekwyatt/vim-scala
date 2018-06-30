require 'rake/testtask'

task :default => :spec
task :test => :spec

Rake::TestTask.new(:spec) do |t|
  t.libs.push "lib"
  t.test_files = Dir.glob('spec/*_spec.rb')
  t.verbose = true
  t.warning = true
end

