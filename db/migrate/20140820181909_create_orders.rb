class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :name
      t.string :address
      t.integer :city_id
      t.float :total_price
      t.timestamps
    end
  end
end
