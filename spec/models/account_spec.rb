require 'rails_helper'

RSpec.describe Account, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  username   :string
#  password   :string
#  contest_id :integer
#  admin      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
