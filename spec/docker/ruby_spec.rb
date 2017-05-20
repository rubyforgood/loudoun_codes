require 'rails_helper'

# 
# SOLUTION_FOLDER=$(pwd)
# docker run -v SOLUTION_FOLDER:/solution -ti lcsi/ruby /execute_problem.sh /solution/ProblemA.rb

in_file = <<-INFILE
meow
meow
INFILE

out_file = <<-OUTFILE
eowmay
eowmay
OUTFILE

good_entry_file = <<-'GOODENTRYFILE'
ARGF.each do |line|
  puts "#{line[1..-1].chomp}#{line[0...1]}ay"
end
GOODENTRYFILE

bad_entry_file = <<-'BADENTRYFILE'
ARGF.each do |line|
  puts "a#{line[1..-1].chomp}#{line[0...1]}ay"
end
BADENTRYFILE


RSpec.describe 'OmniRunner with Ruby', type: :docker do
  describe 'It works with docker command and barebone ruby image' do
    it 'the big picture result here' do
      Dir.mktmpdir {|dir|
        Dir.chdir(dir) {
          input = Docker::Input.create(File.join(dir, 'ProblemA.in'), in_file)
          output = Docker::Output.create(File.join(dir, 'ProblemA.out'), out_file)
          good_entry = Docker::Entry.create(File.join(dir, 'ProblemA.rb'), good_entry_file)
          bad_entry = Docker::Entry.create(File.join(dir, 'ProblemB.rb'), bad_entry_file)

          expect(File.exist? input.path).to be_truthy
          expect(File.exist? output.path).to be_truthy
          expect(File.exist? good_entry.path).to be_truthy
          expect(File.exist? bad_entry.path).to be_truthy

          docker_image = 'ruby'
          language_executable = '/usr/bin/env ruby'
          command = ->entry{
            [
              'docker',
              'run',
              '-a stdin',
              '-a stdout',
              '-a stderr',
              "-v #{Dir.pwd}:#{Dir.pwd} -w #{Dir.pwd}",
              '-i',
              docker_image,
              language_executable,
              entry.path,
              '<',
              input.path,
              '|',
              'diff',
              '-w',
              output.path,
              '-'
            ].join(' ')
          }

          sys_exec(command.call(good_entry))
          expect(@exitstatus).to eq(0)
          expect(out).to eq('')
          expect(err).to eq('')

          sys_exec(command.call(bad_entry))
          expect(@exitstatus).to_not eq(0)
          expect(out).to_not eq('')
          expect(err).to eq('')
        }
      }
    end
  end
end
