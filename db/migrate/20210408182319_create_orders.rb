class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
