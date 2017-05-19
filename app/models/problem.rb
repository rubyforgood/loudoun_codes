class Problem < ApplicationRecord
  has_many :submissions
  belongs_to :contest

  def uploaded_files_dir
    self.class.files_base.join("problems/#{id}")
  end
end
