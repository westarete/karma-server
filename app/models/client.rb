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
class Client < ActiveRecord::Base
  has_many :subscriptions, :dependent => :destroy
  has_many :users, :through => :subscriptions

  validates_presence_of   :hostname, :ip_address, :api_key
  validates_uniqueness_of :hostname, :ip_address, :api_key
  validates_length_of     :api_key, :is => 20
  
  before_validation_on_create :generate_api_key

  attr_accessible :hostname, :ip_address
  
  # Regenerate and assign a new random API key.
  def generate_api_key
    self.api_key = ActiveSupport::SecureRandom.hex(10)
  end
  
  # Ensure that this client will receive future notifications any time the
  # karma for the given user is updated.
  def subscribe_to(user)
    self.users << user
  end
  
  # Stop sending notifications to this client any time the karma for the given
  # user is updated.
  def unsubscribe_from(user)
    self.users.delete(user)
  end
  
  # The URL that we should send karma updates to.
  def notification_url
    "http://#{self.hostname}/karma/updates"
  end
  
  # Send a notification to this client about the given user's karma. If the
  # client responds with a 4xx error, then we will automatically unsubscribe
  # this client from future notifications about this user.
  def push_changes(user)
    RestClient.post self.notification_url, :user => user.permalink, :karma => user.karma
  rescue RestClient::Exception => e
    self.unsubscribe_from(user) if e.response.code >= 400 && e.response_code < 500
  end
  
end
