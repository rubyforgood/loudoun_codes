shared_context "an authorized admin" do
  let(:admin) { Administrator.create! username: "proctor", password: 'asdf123' }

  before do
    visit "/admin/login"
    fill_in "Username", with: admin.username
    fill_in "Password", with: admin.password

    click_on "Log in"
  end

end
