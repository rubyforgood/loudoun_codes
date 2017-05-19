# == Schema Information
#
# Table name: contests
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contest < ApplicationRecord
  has_many :problems
  has_many :teams
end
