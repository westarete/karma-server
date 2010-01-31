require 'spec_helper'

# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer         not null, primary key
#  client_id  :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
describe Subscription do
  before(:each) do
    @subscription = Subscription.make
  end
  
  it { should validate_presence_of :user }
  it { should validate_presence_of :client }
  
end

