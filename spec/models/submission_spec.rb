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
  end
end
