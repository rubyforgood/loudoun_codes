require 'rails_helper'

RSpec.describe "administer a contest" do
  include_context "an authorized admin"

  it "allows editing the contest" do
    visit "/admin"

    click_on "Edit Contest"

    expect(page).to have_content "Name your contest"
    fill_in "Name", with: "A contest of wills"

    click_on "Update Contest"
  end

  it "can start the contest" do
    visit "/admin"

    click_on "Start Contest"

    expect(page).to have_content "Contest started"

    expect(Contest.instance.started_at).to be_within(1).of Time.current
  end

end
