require 'rails_helper'

RSpec.describe SubmissionRunners::Java, type: :docker do
  describe "#call" do
    let(:contest) { Contest.create! }
    let(:team)    { contest.teams.create! }
    let(:problem) do
      p = Problem.new({
        contest:   contest,
        has_input: true,
        name:      problem_name
      })

      input_file = fixtures.join("Input")

      p.define_singleton_method(:input_file) { input_file }

      p
    end
    let(:submission) do
      Submission.create_from_file({
        problem:  problem,
        team:     team,
        filename: fixtures.join("#{problem_name}.java"),
      }).tap(&:validate!)
    end
    let(:fixtures) { Pathname.new(Rails.root).join("spec/fixtures/submission_runners/java") }

    subject(:runner) { described_class.new(submission) }

    before { runner.call }

    context "java code that won't generate compiler or runtime errors" do
      let(:problem_name) { "CompilesAndRuns" }

      it "has no errors" do
        expect(runner.errors).to be_empty
      end
    end

    context "java code that will generate compiler errors" do
      let(:problem_name) { "DoesntCompile" }

      it "has build errors" do
        expect(runner.errors[:build]).to_not be_nil
      end

      it "doesn't have run errors" do
        expect(runner.errors[:run]).to be_nil
      end
    end

    context "java code that will generate runtime errors" do
      let(:problem_name) { "CompilesDoesntRun" }

      it "doesn't have build errors" do
        expect(runner.errors[:build]).to be_nil
      end

      it "has run errors" do
        expect(runner.errors[:run]).to_not be_nil
      end
    end
  end
end
