class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price
      t.text :description
      t.references :style, index: true
      t.references :category, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
