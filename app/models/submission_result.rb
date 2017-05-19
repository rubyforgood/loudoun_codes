class SubmissionResult < ApplicationRecord
  belongs_to :submission
end

# == Schema Information
#
# Table name: submission_results
#
#  id            :integer          not null, primary key
#  output        :text
#  submission_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
