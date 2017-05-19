class Contest < ApplicationRecord
  has_many :problems
  has_many :teams
end
