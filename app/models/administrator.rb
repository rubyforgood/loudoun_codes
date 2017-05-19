class Administrator < ApplicationRecord
  def self.authenticate(username, password)
    admin = Administrator.find_by(username: username)
    if admin.nil?
      false
    else
      admin.password == password
    end
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
