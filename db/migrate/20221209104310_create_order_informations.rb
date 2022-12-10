class CreateOrderInformations < ActiveRecord::Migration[6.1]
  def change
    create_table :order_informations do |t|
      t.integer :customer_id, null: false
      t.string :name, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.integer :postage, null: false
      t.integer :total_amount, null: false
      t.integer :order_status, null: false
      t.integer :payment_method, null: false
      t.timestamps
    end
  end
end
