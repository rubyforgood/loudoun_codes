require 'rails_helper'

RSpec.describe Submission, type: :model do
  describe "#uploaded_files_dir" do
    let(:contest) { Contest.create! }
    let(:submission) do
      Submission.create!({
        team: Team.create!({
          contest: contest
        }),
        problem: Problem.create!({
          contest: contest
        })
      })
    end

    it 'includes the record id' do
      expect(submission.uploaded_files_dir.to_s).to include(submission.id.to_s)
    end

    it 'it has many submission results' do
      contest = Contest.create!(name: "contest")
      problem = Problem.create!(contest: contest)
      team = Team.create!(contest: contest)
      submission = problem.submissions.create!(team: team)
      submission.submission_results.create!
      submission.submission_results.create!
      expect(submission.submission_results.count).to be 2
    end
  end
end

# == Schema Information
#
# Table name: submissions
#
#  id         :integer          not null, primary key
#  passed     :boolean
#  team_id    :integer
#  problem_id :integer
#  runtime    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
