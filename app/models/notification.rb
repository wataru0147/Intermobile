class Notification < ActiveRecord::Base
  

  
  belongs_to :user
  belongs_to :notified_by, :class_name => 'User'
  belongs_to :car
  belongs_to :service_transaction
  
  scope :unread, -> {where(read: false)}
end
