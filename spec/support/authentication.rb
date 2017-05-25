shared_context "an authorized admin" do
  let(:admin) { Account.create! username: "proctor", password: 'asdf123', admin: true, contest: Contest.instance }

  before do
    visit "/login"
    fill_in "Username", with: admin.username
    fill_in "Password", with: admin.password

    click_on "Log in"
  end

end

shared_context "an authorized team" do
  let(:team) do
    Account.create!(username: "team", password: 'asdf123', admin: false, contest: Contest.instance, name: 'Team 1')
  end

  before do
    visit "/login"
    fill_in "Username", with: team.username
    fill_in "Password", with: team.password

    click_on "Log in"
  end

end
