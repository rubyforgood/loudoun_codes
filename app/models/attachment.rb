class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true

  validates :original_filename, presence: true
  validates :attachable_id,     presence: true

  def path
    dir = attachable && attachable.uploaded_files_dir

    Pathname.new(dir.to_s) + original_filename
  end

  def with_file(mode)
    File.open(path, mode) do |file|
      yield file
    end
  end
end

# == Schema Information
#
# Table name: attachments
#
#  id                :integer          not null, primary key
#  original_filename :string
#  content_type      :string
#  attachable_id     :integer
#  attachable_type   :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
