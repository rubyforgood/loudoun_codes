require 'rails_helper'

RSpec.describe SubmissionRunners::Java, type: 'docker' do
  describe "#call" do
    let(:contest) { Contest.instance }
    let(:account) { contest.accounts.create! }
    let(:problem) do
      Problem.create_from_files!({
        contest:     contest,
        name:        problem_name,
        output_file: fixtures.join("Output"),
        input_file:  fixtures.join("Input"),
      })
    end
    let(:submission) do
      Submission.create_from_file({
        problem:  problem,
        account:  account,
        filename: fixtures.join("#{problem_name}.java"),
      }).tap(&:validate!)
    end
    let(:fixtures) { Pathname.new(Rails.root).join("spec/fixtures/submission_runners/java") }

    subject(:runner) { described_class.new(submission) }

    before { runner.call }

    context "java code that won't generate compiler or runtime errors" do
      let(:problem_name) { "CompilesAndRuns" }

      it "has no errors" do
        expect(runner.output).to be_a String
        expect(runner.output_type).to eq "success"
        expect(runner.run_succeeded).to eq true
      end
    end

    context "java code that will generate compiler errors" do
      let(:problem_name) { "DoesntCompile" }

      it "has a build failure" do
        expect(runner.output).to be_a String
        expect(runner.output_type).to eq "build_failure"
        expect(runner.run_succeeded).to eq false
      end
    end

    context "java code that will generate runtime errors" do
      let(:problem_name) { "CompilesDoesntRun" }

      it "has a run failure" do
        expect(runner.output).to be_a String
        expect(runner.output_type).to eq "run_failure"
        expect(runner.run_succeeded).to eq false
      end
    end
  end
end
