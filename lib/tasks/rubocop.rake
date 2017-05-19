require 'rubocop/rake_task'

task :rubocop do
  RuboCop::RakeTask.new
end

task default: :rubocop
