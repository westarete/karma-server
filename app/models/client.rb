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
  validates_presence_of   :hostname, :ip_address, :api_key
  validates_uniqueness_of :hostname, :ip_address, :api_key
end
