# Subscriptions record which clients should be notified about updates to 
# which users.
#
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
class Subscription < ActiveRecord::Base
  belongs_to :client
  belongs_to :user
  
  validates_presence_of :client, :user
  validates_uniqueness_of :client_id, :scope => :user_id
end
