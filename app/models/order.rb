class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_order

  def add_line_order_from_cart(cart)
    cart.line_items.each do |item|
    li = LineOrder.from_cart_item(item)
    line_order << li
    end
  end
end
