require 'rails_helper'
require 'fileutils'

RSpec.describe Docker::Entry, type: :docker do
  describe 'student entry' do
    let(:entry) { Docker::Entry.new(Pathname.new('ProblemA.rb'))}

    it 'exists' do
      expect(Docker::Entry).to_not be_nil
    end

    it 'has a system path' do
      expect(entry.path).to eq(Pathname.new('ProblemA.rb').to_s)
    end

    it "has a basename" do
      expect(entry.basename).to eq('ProblemA')
    end

    it 'can create the file with create' do
      Dir.mktmpdir {|dir|
        Dir.chdir(dir) {
          file = Docker::Entry.create("#{dir}/ProblemX.rb", '')
          expect(file).to be_kind_of(Docker::Entry)

          file = file.path
          expect(File.exist? file).to be_truthy

          FileUtils.rm file
          expect(File.exist? file).to be_falsey
        }
      }
    end
  end
end
