require 'rails_helper'

RSpec.describe 'OmniBuilder with Ruby', docker: true do
  describe 'It works with docker command and barebone ruby image' do
    let(:dir) { Dir.pwd + '/spec/fixtures/docker/' }
    let(:submission) {
      ->i,o,e{
        Object.new.tap{|s|
          s.define_singleton_method :id {0}
          s.define_singleton_method :problem_timeout {nil}
          s.define_singleton_method :source_file {e}
          s.define_singleton_method :problem_input_buffer {i}
          s.define_singleton_method :problem_output_solution_file {o}
          s.define_singleton_method :uploaded_files_dir {o.to_path.rpartition('/').first}
        }
      }
    }

    it 'good entry submission`' do
      input = Docker::Input.new(Pathname.new File.join(dir, 'ProblemA.in'))
      output = Docker::Output.new(Pathname.new File.join(dir, 'ProblemA.out'))
      good_entry = Docker::Entry.new(Pathname.new File.join(dir, 'good', 'ProblemA.rb'))

      expect(File.exist? input.path).to be_truthy
      expect(File.exist? output.path).to be_truthy
      expect(File.exist? good_entry.path).to be_truthy

      runner = SubmissionRunners::Ruby.new submission.call(input, output, good_entry)

      r = runner.build

      expect(r.err).to eq('')
      expect(r.out).to eq('')
      expect(r).to_be :success?
    end

    it 'bad entry submission`' do
      input = Docker::Input.new(Pathname.new File.join(dir, 'ProblemA.in'))
      output = Docker::Output.new(Pathname.new File.join(dir, 'ProblemA.out'))
      bad_entry = Docker::Entry.new(Pathname.new File.join(dir, 'bad', 'ProblemA.rb'))

      expect(File.exist? input.path).to be_truthy
      expect(File.exist? output.path).to be_truthy
      expect(File.exist? bad_entry.path).to be_truthy

      builder = Docker::RubyBuilder.new

      sys_exec(builder.build(bad_entry, input, output))
      expect(err).to eq('')
      expect(out).to_not eq('')
      expect(@exitstatus).to_not eq(0)
    end
  end
end
