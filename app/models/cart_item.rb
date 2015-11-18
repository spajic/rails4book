class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :order
  belongs_to :product

  def total_price 
  	product.price * quantity
  end
end
