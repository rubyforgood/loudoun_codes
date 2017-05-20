require 'rails_helper'

RSpec.describe "Admin::Teams", type: :request do
  include_context "a configured contest"
  let(:admin) { Account.create! username: "proctor", password: 'asdf123', contest: Contest.instance, admin: true }

  describe "GET /admin/teams" do

    it "works! (now write some real specs)" do
      # I hate this so much.  Request specs should be able to test _a single
      # request_ in isolation.  Without access to the session, we are forced
      # to treat these as full integrations, with multiple page posts
      post login_path params: {
        session: { username: admin.username, password: admin.password }
      }

      get admin_teams_path
      expect(response).to have_http_status(200)
    end
  end
end
