require 'rails_helper'

RSpec.feature 'Admin scoreboard', :type => :feature do
  scenario 'admin scoreboard is accessible to admins' do
    # TODO Update when authorization is in place
    visit admin_scoreboard_path(logged_in: true)

    expect(current_path).to eq(admin_scoreboard_path)
  end

  scenario 'admin scoreboard is not accessible to participants' do
    visit admin_scoreboard_path

    expect(current_path).to eq(root_path)
  end
end
