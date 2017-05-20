require 'rails_helper'
require 'submission_runners/java'
require 'fixtures/submission_runners/java/submissions'

RSpec.describe SubmissionRunners::Java do
  describe "#do_the_thing" do
    let(:output_fixture) do
      Pathname.new(Rails.root).join("spec/fixtures/submission_runners/java/Output")
    end

    subject(:runner) { described_class.new(submission) }

    before { runner.call }

    context "java code that won't generate compiler or runtime errors" do
      let(:submission) { CompilesAndRuns }

      it "has no errors" do
        expect(runner.errors).to be_empty
      end
    end

    context "java code that will generate compiler errors" do
      let(:submission) { DoesntCompile }

      it "has errors" do
        expect(runner.errors).to_not be_empty
      end
    end

    context "java code that will generate runtime errors" do
      let(:submission) { CompilesDoesntRun }

      it "has errors" do
        expect(runner.errors).to_not be_empty
      end
    end    
  end
end
