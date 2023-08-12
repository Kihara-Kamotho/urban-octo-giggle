class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.integer :amount, default: 0
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
