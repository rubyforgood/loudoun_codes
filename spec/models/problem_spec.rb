# == Schema Information
#
# Table name: problems
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  contest_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Problem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
