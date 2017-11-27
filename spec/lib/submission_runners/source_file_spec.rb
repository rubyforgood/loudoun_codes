require 'rails_helper'

module SubmissionRunners
  RSpec.describe SourceFile do
    it "implements Pathname's methods" do
      # The next easiest way to test interface conformance in Ruby
      #   is much more annoying to set up. Easier to have the spec
      #   title declare our intent correctly (which it does), and
      #   "bind" the test itself to our particular implementation.
      expect(SourceFile).to be < Pathname
    end

    describe '#without_extension' do
      subject (:source_file) { SourceFile.new('package.json') }

      it 'returns a SourceFile instance' do
        expect(source_file.without_extension).to be_kind_of SourceFile
      end

      it 'strips the file extension' do
        expect(source_file.without_extension).to eq SourceFile.new('package')
      end
    end
  end
end
