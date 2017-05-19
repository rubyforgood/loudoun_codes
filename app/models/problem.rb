# == Schema Information
#
# Table name: problems
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  contest_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Problem < ApplicationRecord
  has_many :submissions
  belongs_to :contest
end
