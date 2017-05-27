require 'rails_helper'

RSpec.describe SubmissionRunners::Cpp, type: 'docker' do
  describe '#call' do
    let(:fixtures) { Pathname.new(Rails.root).join('spec/fixtures/submission_runners/cpp') }
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
        filename: fixtures.join("#{problem_name}.cc"),
      }).tap(&:validate!)
    }

    subject(:runner) { described_class.new submission }

    before { runner.call }

    context 'good entry submission' do
      let(:problem_name) { 'compiles_and_runs' }

      it 'builds and runs with call' do
        expect(runner.output).to eq(problem.output)
        expect(runner.output_type).to eq('success')
        expect(runner.run_succeeded?).to eq true
      end
    end

    context "compiles and doesn't run entry submission" do
      let(:problem_name) { 'compiles_and_doesnt_run' }

      it 'builds and runs with call' do
        expect(runner.output).to be_a String
        expect(runner.output_type).to eq('run_failure')
        expect(runner.run_succeeded?).to eq false
      end
    end

    context "doesn't compile entry submission" do
      let(:problem_name) { 'doesnt_compile' }

      it 'builds and runs with call' do
        expect(runner.output).to be_a String
        expect(runner.output_type).to eq('build_failure')
        expect(runner.run_succeeded?).to eq false
      end
    end
  end
end
