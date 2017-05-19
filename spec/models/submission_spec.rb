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

require 'rails_helper'

RSpec.describe Submission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
