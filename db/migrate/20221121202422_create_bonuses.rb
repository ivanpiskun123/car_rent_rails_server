class CreateBonuses < ActiveRecord::Migration[6.1]
  def change
    create_table :bonuses do |t|
      t.integer :amount, null: false, default: 0
      t.boolean :is_used, null: false, default: false

      t.timestamps
    end

    add_reference :bonuses, :user, foreign_key: true

  end
end
