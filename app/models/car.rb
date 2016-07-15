class Car < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :car_manufacturer
  belongs_to :car_model
  has_many :service_transactions

end
