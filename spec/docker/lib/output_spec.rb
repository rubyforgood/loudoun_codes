require 'rails_helper'
require 'fileutils'

RSpec.describe Docker::Output, docker: true do
  describe 'output for entry' do
    let(:output) { Docker::Output.new(Pathname.new('ProblemA.out')) }

    it 'exists' do
      expect(Docker::Output).to_not be_nil
    end

    it 'has a system path' do
      expect(output.path).to eq(Pathname.new('ProblemA.out').to_s)
    end

    it 'can create the file with create' do
      Dir.mktmpdir { |dir|
        Dir.chdir(dir) {
          file = Docker::Output.create("#{dir}/ProblemX.out", 'eowmay\neowmay')
          expect(file).to be_kind_of(Docker::Output)

          file = file.path
          expect(File.exist? file).to be_truthy

          FileUtils.rm file
          expect(File.exist? file).to be_falsey
        }
      }
    end
  end
end
