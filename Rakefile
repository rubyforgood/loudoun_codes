# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

desc 'Build Custom Docker Images'
task 'dockerbuild' do
  desc 'Rust'
  rust_version = File.read('config/dockerfiles/Dockerfile.Rust')[/(?<=ENV RUST_VERSION=)\d+.\d+.\d+/]
  system(*%W[docker build -f config/dockerfiles/Dockerfile.Rust -t rust:#{rust_version} config/dockerfiles])
end

desc 'Pull Docker Images'
task docker: [:dockerbuild] do
  require_relative 'lib/submission_runners'
  require 'set'
  Dir['lib/submission_runners/*'].each do |f| require_relative f end
  include SubmissionRunners
  Set.new(SubmissionRunners.language_extension_map.values).each do |language|
    system(*%W[docker pull #{language.image}])
  end
end
