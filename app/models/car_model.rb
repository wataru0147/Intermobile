class CarModel < ActiveRecord::Base
  

  belongs_to :car_manufacturer
  has_many :cars
  #belongs_to :cars through: :car_manufacturer


end
