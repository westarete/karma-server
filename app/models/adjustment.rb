# = Adjustment
#
# The adjustment model is used to store changes to karma. Each adjustment
# has a single positive or negative value, which is applied to a given user's
# bucket.
#
# == Schema Information
#
# Table name: adjustments
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  bucket_id  :integer         not null
#  value      :integer         not null
#  created_at :datetime
#  updated_at :datetime
#

class Adjustment < ActiveRecord::Base
  validates_presence_of :user_id, :bucket_id, :value
  validates_numericality_of :value
  default_scope :order => :created_at
  
  belongs_to :user
  belongs_to :bucket
  
  attr_accessible :value
  
  after_save :notify_subscribers
  
  # Send out updates to all of the clients that have subscribed to karma
  # changes for this user.
  def notify_subscribers
    self.user.subscribers.each do |client|
      client.send_later(:push_changes, self.user)
    end
  end
end
