class CreatePaymentCards < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_cards do |t|
      t.string :code ,null: false, default: ""
      t.string :cvv, null: false, default: ""
      t.string :date_exp, null: false, default: ""
      t.timestamps
    end
    add_reference :payment_cards, :user, foreign_key: true

  end
end
