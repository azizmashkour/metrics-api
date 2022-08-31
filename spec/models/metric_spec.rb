require "rails_helper"
RSpec.describe Metric, :type => :model do
  
  before(:all) do
    @metric1 = create(:metric)
  end
  
  it "is valid with valid attributes" do
    expect(@metric1).to be_valid
  end
  
  it "is not valid without a name" do 
    metric2 = build(:metric, name: nil)
    expect(metric2).to_not be_valid
  end
  
  it "is not valid without a value" do 
    metric2 = build(:metric, value: nil)
    expect(metric2).to_not be_valid
  end
  
  it "is not valid without an timestamp" do
    metric2 = build(:metric, timestamp: nil)
    expect(metric2).to_not be_valid
  end
end