require 'rails_helper'

RSpec.feature 'Admin create problems', type: :feature do
  include_context "a configured contest"
  include_context "an authorized admin"

  scenario 'An admin can create a problem with attached inputs and solutions' do
    visit admin_contest_path

    click_on "Create Problem"
    fill_in "Name", with: "Shortest Path"
    fill_in "Description", with: "Find the shortest paths between the given points"
    fill_in "Timeout", with: 30

    check "Ignore case"
    select "ignore trailing whitespace", from: "Whitespace rule"

    click_on "Create Problem"

    expect(page.body).to have_content("Shortest Path")
      .and have_content("paths between the given points")
  end
end
