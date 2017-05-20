require 'rails_helper'

RSpec.describe 'OmniBuilder with Python', type: :docker do
  describe 'It works with docker command and barebone python image' do
    let(:dir) { Dir.pwd + '/spec/fixtures/docker/' }

    it 'good entry submission`' do
      input = Docker::Input.new(Pathname.new File.join(dir, 'ProblemA.in'))
      output = Docker::Output.new(Pathname.new File.join(dir, 'ProblemA.out'))
      good_entry = Docker::Entry.new(Pathname.new File.join(dir, 'good', 'ProblemA.py'))

      expect(File.exist? input.path).to be_truthy
      expect(File.exist? output.path).to be_truthy
      expect(File.exist? good_entry.path).to be_truthy

      builder = Docker::PythonBuilder.new(dir)

      sys_exec(builder.build(good_entry, input, output))
      expect(err).to eq('')
      expect(out).to eq('')
      expect(@exitstatus).to eq(0)
    end

    it 'bad entry submission`' do
      input = Docker::Input.new(Pathname.new File.join(dir, 'ProblemA.in'))
      output = Docker::Output.new(Pathname.new File.join(dir, 'ProblemA.out'))
      bad_entry = Docker::Entry.new(Pathname.new File.join(dir, 'bad', 'ProblemA.py'))

      expect(File.exist? input.path).to be_truthy
      expect(File.exist? output.path).to be_truthy
      expect(File.exist? bad_entry.path).to be_truthy

      builder = Docker::PythonBuilder.new(dir)

      sys_exec(builder.build(bad_entry, input, output))
      expect(err).to eq('')
      expect(out).to_not eq('')
      expect(@exitstatus).to_not eq(0)
    end
  end
end
