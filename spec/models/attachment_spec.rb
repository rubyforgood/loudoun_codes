require 'rails_helper'

RSpec.describe Attachment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
