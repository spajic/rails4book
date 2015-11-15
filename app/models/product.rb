class Product < ActiveRecord::Base
	has_many :cart_items

	before_destroy :ensure_not_referenced_by_any_cart_item

	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :title, uniqueness: true
	validates :image_url, allow_blank: true, format: {
		with: /\.(gif|jpg|png)\Z/i,
		message: 'URL must have one of extensions: jpg, png, gif'
	}

	private
	def ensure_not_referenced_by_any_cart_item
		if cart_items.empty?
			return true
		else
			errors.add(:base, 'dependent cart items exist!')
			return false
		end
	end
end
