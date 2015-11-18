class Order < ActiveRecord::Base
	has_many :cart_items, dependent: :destroy
	PAYMENT_TYPES = ['Check', 'Credit card', 'Purchase order']
	validates :name, :address, :email, presence: true
	validates :pay_type, inclusion: PAYMENT_TYPES

	def add_cart_items_from_cart(cart)
		cart.cart_items.each do |item|
			item.cart_id = nil
			cart_items.push item
		end
	end
end
