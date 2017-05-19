class Submission < ApplicationRecord
  has_many :submission_results
  belongs_to :team
  belongs_to :problem

  def uploaded_files_dir
    self.class.files_base.join("submissions/#{id}")
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