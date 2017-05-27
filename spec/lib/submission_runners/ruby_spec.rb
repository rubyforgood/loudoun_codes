require 'rails_helper'

RSpec.describe SubmissionRunners::Ruby, type: 'docker' do
  describe '#call' do
    let(:fixtures) { Pathname.new(Rails.root).join('spec/fixtures/submission_runners/ruby/') }
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
        filename: fixtures.join("#{problem_name}.rb"),
      }).tap(&:validate!)
    }

    subject(:runner) { described_class.new submission }

    context 'good entry submission' do
      let(:problem_name) { 'good_run' }

      it "runs via call" do
        runner.call
        expect(runner.output).to eq(problem.output)
        expect(runner.output_type).to eq("success")
        expect(runner.run_succeeded).to be_truthy
      end
    end

    context 'invalid syntax entry submission' do
      let(:problem_name) { 'corrupt_code' }

      it "fails run via call" do
        runner.call
        expect(runner.output_type).to eq("run_failure")
        expect(runner.run_succeeded).to be_falsey
      end
    end
  end
end
