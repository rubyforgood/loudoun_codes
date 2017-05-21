require 'rails_helper'

RSpec.describe RunSubmissionJob, type: :job do
  let(:contest) { Contest.create! }
  let(:team)    { contest.teams.create! }
  let(:problem) do
    Problem.create_from_files!({
      contest:     contest,
      name:        "CompilesAndRuns",
      output_file: fixtures.join("Output"),
      input_file:  fixtures.join("Input"),
    })
  end
  let(:submission) do
    Submission.create_from_file({
      problem:  problem,
      team:     team,
      filename: fixtures.join("#{problem.name}.java"),
    }).tap(&:validate!)
  end
  let(:fixtures) { Pathname.new(Rails.root).join("spec/fixtures/submission_runners/java") }

  it 'creates a submission result' do
    RunSubmissionJob.new.perform(submission.id)

    expect(submission.reload.submission_results.count).to eq(1)
  end
end
