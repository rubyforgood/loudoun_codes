class Problem < ApplicationRecord
  has_many :submissions
  belongs_to :contest
end
