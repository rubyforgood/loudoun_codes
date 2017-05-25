require 'rails_helper'

RSpec.describe SubmissionRunners::Cpp, type: 'docker' do
  describe 'docker command and barebone C++ image' do
    let(:fixtures) do
      Pathname.new(Rails.root).
      join('spec/fixtures/submission_runners/cpp')
    end

    before { @keep_files = Dir.entries(fixtures) }

    after do
      compiled = Dir.entries(fixtures) - @keep_files
      compiled.each do |file|
        FileUtils.rm File.join(fixtures, file)
      end
    end

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

    context 'good entry submission' do
      let(:problem_name) { 'compiles_and_runs' }

      it 'builds' do
        b = runner.build
        expect(b.err).to eq('')
        expect(b.out).to_not eq(problem.output)
        expect(b.success?).to be_truthy
      end

      it 'runs' do
        runner.build
        r = runner.run
        expect(r.err).to eq('')
        expect(r.out).to eq(problem.output)
        expect(r.success?).to be_truthy
      end

      it 'builds and runs with call' do
        runner.call
        expect(runner.output).to eq(problem.output)
        expect(runner.output_type).to eq('success')
        expect(runner.run_succeeded).to be_truthy
      end
    end

    context 'failing entry submission' do
      let(:problem_name) { 'compiles_and_runs_wrong_answer' }

      it 'builds' do
        b = runner.build
        expect(b.err).to eq('')
        expect(b.out).to_not eq(problem.output)
        expect(b.success?).to be_truthy
      end

      it 'runs' do
        runner.build
        r = runner.run
        expect(r.err).to eq('')
        expect(r.out).to_not eq(problem.output)
        expect(r.success?).to be_truthy
      end

      it 'builds and runs with call' do
        runner.call
        expect(runner.output).to_not eq(problem.output)
        expect(runner.output_type).to eq('success')
        expect(runner.run_succeeded).to be_truthy
      end
    end

    context 'compiles and doesn\'t run entry submission' do
      let(:problem_name) { 'compiles_and_doesnt_run' }

      it 'builds' do
        b = runner.build
        expect(b.err).to eq('')
        expect(b.out).to_not eq(problem.output)
        expect(b.success?).to be_truthy
      end

      it 'runs' do
        runner.build
        r = runner.run
        expect(r.err).to_not eq('')
        expect(r.out).to_not eq(problem.output)
        expect(r.success?).to be_falsey
      end

      it 'builds and runs with call' do
        runner.call
        expect(runner.output).to_not eq(problem.output)
        expect(runner.output_type).to eq('run_failure')
        expect(runner.run_succeeded).to be_falsey
      end
    end

    context 'doesn\'t compile entry submission' do
      let(:problem_name) { 'doesnt_compile' }

      it 'builds' do
        b = runner.build
        expect(b.err).to_not eq('')
        expect(b.out).to_not eq(problem.output)
        expect(b.success?).to be_falsey
      end

      it 'runs' do
        runner.build
        r = runner.run
        expect(r.err).to_not eq('')
        expect(r.out).to_not eq(problem.output)
        expect(r.success?).to be_falsey
      end

      it 'builds and runs with call' do
        runner.call
        expect(runner.output).to_not eq(problem.output)
        expect(runner.output_type).to eq('build_failure')
        expect(runner.run_succeeded).to be_falsey
      end
    end
  end
end
