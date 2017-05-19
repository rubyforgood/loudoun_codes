class Team < ApplicationRecord
  belongs_to :contest
  has_many :submissions
end

# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  username   :string
#  password   :string
#  contest_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
