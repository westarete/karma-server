# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  permalink  :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  has_many :adjustments, :dependent => :destroy
  has_many :subscriptions, :dependent => :destroy
  has_many :subscribers, :through => :subscriptions, :source => :client
  
  validates_presence_of   :permalink
  validates_uniqueness_of :permalink
  validate :valid_permalink
  
  default_scope :order => :permalink
  
  attr_protected :created_at, :updated_at
  
  def to_param
    permalink
  end
  
  # Return the total karma value for a given bucket for this user
  def karma_for(bucket)
    Adjustment.sum('value', :conditions => ["user_id = ? and bucket_id = ?", id, bucket.id])
  end
  
  # Return the total adjustment value for this user
  # described as the user's total karma
  def karma
    Adjustment.sum('value', :conditions => ["user_id = ?", id])
  end
  
  private
  def valid_permalink
    unless self.permalink.nil?
      if self.permalink.include?(".")
        errors.add(:permalink, "can't have a period")
      end
      if self.permalink.include?("/")
        errors.add(:permalink, "can't have a slash")
      end
      case self.permalink
      when "index", "new", "create", "edit", "update", "show"
        errors.add(:permalink, "can't be index, new, create, edit, update or show")
      end
    end
  end
  
end
