class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.float :total_price
      t.timestamps
    end
  end
end
