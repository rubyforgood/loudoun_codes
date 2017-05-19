require 'rails_helper'

RSpec.describe RunSubmissionJob, type: :job do
  it 'creates a submission result' do
    contest    = Contest.create
    team       = Team.create(contest: contest)
    problem    = Problem.create(contest: contest)
    submission = Submission.create(problem: problem, team: team)

    RunSubmissionJob.new.perform(submission.id)

    expect(submission.reload.submission_results.count).to eq(1)
  end
end
