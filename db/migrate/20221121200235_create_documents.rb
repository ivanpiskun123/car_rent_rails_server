class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.integer :status, null: false, default: 1
      t.timestamps
    end

    add_reference :documents, :user, foreign_key: true
  end
end
