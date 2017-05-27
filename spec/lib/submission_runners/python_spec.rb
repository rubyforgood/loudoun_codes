require 'rails_helper'

RSpec.describe SubmissionRunners::Python, type: 'docker' do
  describe '#call' do
    let(:fixtures) { Pathname.new(Rails.root).join('spec/fixtures/submission_runners/python/') }
    let(:contest) { Contest.instance }
    let(:account) { contest.accounts.create! }

    let(:problem) do
      Problem.create_from_files!({
        contest:     contest,
        name:        problem_name,
        input_file:  fixtures.join('ProblemA.in'),
        output_file: fixtures.join('ProblemA.out'),
      })
    end

    let(:submission) {
      Submission.create_from_file({
        problem:  problem,
        account:  account,
        filename: fixtures.join("#{problem_name}.py"),
      }).tap(&:validate!)
    }

    subject(:runner) { described_class.new submission }

    before { runner.call }

    context 'good entry submission' do
      let(:problem_name) { 'good_run' }

      it "runs via call" do
        expect(runner.output).to eq(problem.output)
        expect(runner.output_type).to eq("success")
        expect(runner.run_succeeded?).to eq true
      end
    end

    context 'invalid syntax entry submission' do
      let(:problem_name) { 'corrupt_code' }

      it "fails run via call" do
        expect(runner.output).to be_a String
        expect(runner.output_type).to eq("run_failure")
        expect(runner.run_succeeded?).to eq false
      end
    end
  end
end
