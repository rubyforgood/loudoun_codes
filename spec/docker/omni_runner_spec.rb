require 'rails_helper'

RSpec.describe Docker::OmniRunner, type: :docker do
  describe "it exists" do
    it "exists" do
      expect(Docker::OmniRunner).to_not be_nil
    end
  end
end
