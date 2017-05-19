class Submission < ApplicationRecord
  has_many :submission_results
  belongs_to :team
  belongs_to :problem

  def uploaded_files_dir
    self.class.files_base.join("submissions/#{id}")
  end
end
