RSpec.describe Promotxter do
  it "has a version number" do
    expect(Promotxter::VERSION).not_to be nil
  end

  it "has an initialize method" do
  	expect(Promotxter::Client).to respond_to? :initialize
  end
end
