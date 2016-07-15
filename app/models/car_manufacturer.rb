class CarManufacturer < ActiveRecord::Base

	has_many :cars, through: :car_models
	has_many :car_models
	
end
