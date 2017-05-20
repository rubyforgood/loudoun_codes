require 'rails_helper'

RSpec.describe Administrator, type: :model do
  it "returns administrator when authentication is successful" do
    Administrator.create(username: "admin", password: "admin")
    expect(Administrator.authenticate("admin", "admin")).to be_instance_of Administrator

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
