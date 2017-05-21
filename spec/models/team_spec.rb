require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'it has many submissions' do
    contest = Contest.instance
    problem = contest.problems.create!
    account = Account.create!(contest: contest)
    submission = problem.submissions.create!(account: account)
    submission = problem.submissions.create!(account: account)
    expect(account.submissions.count).to be 2
  end

end

# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string
#  username   :string
#  password   :string
#  contest_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
