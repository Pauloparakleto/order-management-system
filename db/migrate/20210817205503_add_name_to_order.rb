class AddNameToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :product_name, :string
    add_column :orders, :price, :decimal, precision: 6, scale: 2
  end
end
