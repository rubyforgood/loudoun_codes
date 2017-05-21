require 'rails_helper'
require 'submission_runners/java'
require 'fixtures/submission_runners/java/submissions'

RSpec.describe SubmissionRunners::Java, docker: true do
  describe "#call" do
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

      it "has build errors" do
        expect(runner.errors[:build]).to_not be_nil
      end

      it "doesn't have run errors" do
        expect(runner.errors[:run]).to be_nil
      end
    end

    context "java code that will generate runtime errors" do
      let(:submission) { CompilesDoesntRun }

      it "doesn't have build errors" do
        expect(runner.errors[:build]).to be_nil
      end

      it "has run errors" do
        expect(runner.errors[:run]).to_not be_nil
      end
    end
  end
end
