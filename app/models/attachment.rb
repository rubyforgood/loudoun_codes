class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true
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
