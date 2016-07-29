class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :service_transaction

  validates :content, presence: true
end
