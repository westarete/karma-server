require 'spec_helper'

# == Schema Information
#
# Table name: clients
#
#  id         :integer         not null, primary key
#  api_key    :string(255)     not null
#  ip_address :string(255)     not null
#  hostname   :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#
describe Client do
  before(:each) do
    @client = Client.make
  end

  it { should validate_presence_of :hostname }
  it { should validate_presence_of :ip_address }
  it { should validate_uniqueness_of :hostname }
  it { should validate_uniqueness_of :ip_address }

  it "should generate the API key automatically" do
    @client.api_key.should_not be_nil
  end

  it "should generate an API key of the maximum length allowed by HTTP basic authentication" do
    @client.api_key.length.should == 20
  end

  it "should not allow mass assignment of the api key" do
    original_value = @client.api_key
    @client.update_attributes(:api_key => 'something else')
    @client.api_key.should == original_value
  end

end

