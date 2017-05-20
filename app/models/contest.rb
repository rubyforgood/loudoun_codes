class Contest < ApplicationRecord
  has_many :problems
  has_many :teams

  def self.instance
    order(:created_at).reverse.first
  end
end

# == Schema Information
#
# Table name: contests
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
