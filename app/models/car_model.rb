class CarModel < ActiveRecord::Base
  

  belongs_to :car_manufacturer
  has_many :cars
  #belongs_to :cars through: :car_manufacturer

  validates :name, presence: true, uniqueness: true
  validates :car_manufacturer_id, presence: true


end
