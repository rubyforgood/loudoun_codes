require 'rails_helper'

RSpec.describe "administer a contest" do
  include_context "an authorized admin"

  context "when no contest exists" do
    it "prompts to create a new contest" do
      visit "/admin"

      click_on "Edit contest"

      expect(page).to have_content "Name your contest"
      fill_in "Name", with: "A contest of wills"

      click_on "Update Contest"
    end
  end

end
