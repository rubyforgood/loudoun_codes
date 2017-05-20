class Administrator < ApplicationRecord
  def self.authenticate(username, token)
    Administrator.find_by(username: username, password: token)
  end
end

# == Schema Information
#
# Table name: administrators
#
#  id         :integer          not null, primary key
#  username   :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
