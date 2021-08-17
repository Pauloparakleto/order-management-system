class CreateOrderSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :order_settings do |t|
      t.integer :last_number

      t.timestamps
    end
  end
end
