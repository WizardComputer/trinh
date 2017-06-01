class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :product
      t.integer :number
      t.references :account

      t.timestamps
    end
  end
end
