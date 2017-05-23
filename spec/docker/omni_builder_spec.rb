require 'rails_helper'

RSpec.describe Docker::OmniBuilder, type: 'docker' do
  describe "Builder Protocol" do
    let(:runner) { Docker::OmniBuilder.new('/') }
    it "it exists" do
      expect(Docker::OmniBuilder).to_not be_nil
    end

    it 'responds to run' do
      expect(runner).to respond_to(:build)
    end
  end
end
