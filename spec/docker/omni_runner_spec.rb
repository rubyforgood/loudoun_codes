require 'rails_helper'

RSpec.describe Docker::OmniRunner, type: :docker do
  describe "Runner Protocol" do
    let(:runner) { Docker::OmniRunner.new('/') }
    it "it exists" do
      expect(Docker::OmniRunner).to_not be_nil
    end

    it 'responds to run' do
      expect(runner).to respond_to(:run)
    end
  end
end
