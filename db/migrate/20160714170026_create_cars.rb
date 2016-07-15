class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :plate_number
      t.string :year
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
