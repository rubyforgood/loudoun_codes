shared_context "a configured contest" do
  before do
    Contest.create! name: 'A Test Contest'
  end
end
