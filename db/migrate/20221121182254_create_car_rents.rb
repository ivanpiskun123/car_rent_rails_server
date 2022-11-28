class CreateCarRents < ActiveRecord::Migration[6.1]
  def change
    create_table :car_rents do |t|
      t.datetime :ended_at
      t.boolean :is_paid,  null: false, default: false

      t.timestamps
    end

    add_reference :car_rents, :car, foreign_key: true
    add_reference :car_rents, :user, foreign_key: true

  end
end
