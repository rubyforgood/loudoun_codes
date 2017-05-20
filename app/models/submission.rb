class Submission < ApplicationRecord
  has_one :attachment, as: :attachable, validate: true
  has_many :submission_results
  belongs_to :team
  belongs_to :problem

  validate do
    if attachment && attachment.attachment_type != 'solution'
      errors.add :attachment, 'Must be a solution'
    end
  end

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
