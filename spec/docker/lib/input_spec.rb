require 'rails_helper'
require 'fileutils'

RSpec.describe Docker::Input, type: :docker do
  describe 'input for entry' do
    let(:input) { Docker::Input.new(Pathname.new('ProblemA.rb')) }

    it 'exists' do
      expect(Docker::Input).to_not be_nil
    end

    it 'has a system path' do
      expect(input.path).to eq(Pathname.new('ProblemA.rb').to_s)
    end

    it 'can create the file with create' do
      Dir.mktmpdir { |dir|
        Dir.chdir(dir) {
          file = Docker::Input.create("#{dir}/ProblemX.in", 'meow\nmeow')
          expect(file).to be_kind_of(Docker::Input)

          file = file.path
          expect(File.exist? file).to be_truthy

          FileUtils.rm file
          expect(File.exist? file).to be_falsey
        }
      }
    end
  end
end
