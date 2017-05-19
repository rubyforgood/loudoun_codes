class Submission < ApplicationRecord
  has_many :submission_results
  belongs_to :team
  belongs_to :problem
end
