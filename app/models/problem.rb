class Problem < ApplicationRecord
  has_many :attachments, as: :attachable
  has_many :submissions
  belongs_to :contest

  WHITESPACE_RULES = ["plain diff", "ignore all whitespace", "ignore leading whitespace", "ignore trailing whitespace"]

  def uploaded_files_dir
    self.class.files_base.join("problems/#{id}")
  end
end

# == Schema Information
#
# Table name: problems
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text
#  contest_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  timeout         :integer
#  has_input       :boolean
#  auto_judge      :boolean
#  ignore_case     :boolean
#  whitespace_rule :string           default("plain diff")
#
