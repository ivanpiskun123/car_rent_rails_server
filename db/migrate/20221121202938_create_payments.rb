class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.boolean :is_paid, null: false, default: false
      t.integer :amount, null: false, default: 0

      t.timestamps
    end

    add_reference :payments, :car_rent, foreign_key: true

  end
end
