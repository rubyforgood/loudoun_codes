require 'rails_helper'

RSpec.describe SubmissionRunners::Haskell, type: 'docker' do
  describe 'docker command and barebone Haskell image' do
    let(:fixtures) { Pathname.new(Rails.root).join('spec/fixtures/submission_runners/haskell') }
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
        filename: fixtures.join("#{problem_name}.hs"),
      }).tap(&:validate!)
    }

    subject(:runner) { described_class.new submission }

    before { runner.call }

    context 'code that compiles and runs' do
      let(:problem_name) { 'compiles_and_runs' }

      it 'has no failures' do
        expect(runner.output).to eq(problem.output)
        expect(runner.output_type).to eq('success')
        expect(runner.run_succeeded?).to eq true
      end
    end

    context 'code that compiles and runs wrong answer' do
      let(:problem_name) { 'compiles_and_runs_wrong_answer' }

      it 'has an incorrect answer' do
        expect(runner.output).not_to eq(problem.output)
        expect(runner.output_type).to eq('success')
        expect(runner.run_succeeded?).to eq true
      end
    end

    context 'code that compiles but doesn\'t run' do
      let(:problem_name) { 'compiles_and_doesnt_run' }

      it 'has a run failure' do
        expect(runner.output).to be_a String
        expect(runner.output_type).to eq('run_failure')
        expect(runner.run_succeeded?).to eq false
      end
    end

    context 'code that doesn\'t compile' do
      let(:problem_name) { 'doesnt_compile' }

      it 'has a build failure' do
        expect(runner.output).to be_a String
        expect(runner.output_type).to eq('build_failure')
        expect(runner.run_succeeded?).to eq false
      end
    end
  end
end
