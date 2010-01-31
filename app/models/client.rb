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
  validates_presence_of   :hostname, :ip_address
  validates_uniqueness_of :hostname, :ip_address
  
  before_validation_on_create :generate_api_key

  attr_accessible :hostname, :ip_address
  
  # Regenerate and assign a new random API key.
  def generate_api_key
    self.api_key = ActiveSupport::SecureRandom.hex(32)
  end
end
