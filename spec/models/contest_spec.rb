require 'rails_helper'

RSpec.describe Contest, type: :model do
  it "has many problems" do
    contest = Contest.create!(name: "contest")
    contest.problems.create
    contest.problems.create
    expect(contest.problems.count).to be 2
  end

  it "has many teams" do
    contest = Contest.create!(name: "contest")
    contest.teams.create
    contest.teams.create
    expect(contest.teams.count).to be 2
  end

end

# == Schema Information
#
# Table name: contests
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
