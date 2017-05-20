require 'rails_helper'

RSpec.feature 'administrator can create teams', type: :feature do
  include_context "a configured contest"
  include_context "an authorized admin"

  scenario "an admin can create new teams" do
    pending

    visit admin_contest_path

    click_on "Manage Teams"

    teams = [{ name: "A quick and speedy team", username: "roadrunner" },
             { name: "Move fast and break things", username: "hare" },
             { name: "Slow and steady", username: "tortise" }]

    teams.each do |name, user|
      click_on "Add New Team"

      fill_in "Name", with: "A quick and speedy team"
      fill_in "username", with: "roadrunner"

      click_on "Create Team"
    end

    expect(@contest.teams.count).to eq 3

    teams.each do |t|
      expect(page).to have_content t[:name]
    end
  end

end
