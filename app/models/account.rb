class Account < ApplicationRecord
  belongs_to :contest
  has_many :submissions

  def self.authenticate(username, token)
    Account.find_by(username: username, password: token)
  end
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
