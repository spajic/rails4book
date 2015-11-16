class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy

  def add_product(product_id)
  	current_cart_item = cart_items.find_by(product_id: product_id)
  	if current_cart_item
  		current_cart_item.quantity += 1
  	else
  		current_cart_item = cart_items.build(product_id: product_id)
  	end
  	current_cart_item
  end

  def total_price
    cart_items.to_a.sum{|ci| ci.total_price}
  end
  
end
