require 'rails_helper'

RSpec.feature 'Admin create problems', type: :feature do
  #include_context "an authorized admin"

  scenario 'An admin can create a problem with attached inputs and solutions' do
    pending "feature in development"

    visit admin_contest_path(logged_in: true)

    click_on "Create Problem"
    fill_in "Name", with: "Shortest Path"
    fill_in "Description", with: "Find the shortest paths between the given points"

    # TODO Attach the files

    expect(response).to have_content("Shortest Path")
      .and have_content("paths between the given points")
  end
end
