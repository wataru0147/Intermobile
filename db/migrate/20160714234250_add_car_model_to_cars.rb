class AddCarModelToCars < ActiveRecord::Migration
  def change
    add_reference :cars, :car_model, index: true, foreign_key: true
  end
end
