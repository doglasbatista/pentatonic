class LineOrder < ActiveRecord::Migration
  def change
    create_table :line_orders do |t|
      t.references :product, index: true
      t.references :order, index: true
      t.integer :quantity
      t.float :total_price
    end
  end
end
