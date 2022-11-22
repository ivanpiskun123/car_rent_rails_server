class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.integer :price_per_min, null: false, default: 1

      t.string :name, null: false, default: ""
      t.float :engine_volume, null: false, default: 2.0
      t.integer :edition_year, null: false, default: 0
      t.integer :condition, null: false, default: 10

      t.boolean :ready_to_rent, null: false, default: true

      t.timestamps
    end

    add_reference :cars, :fuel_type, foreign_key: true
    add_reference :cars, :car_brand, foreign_key: true

  end
end
