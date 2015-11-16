require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test "adding product that's already in cart increases quantity" do
     cart = carts(:cart_of_rubyst)
     ruby_book = products(:ruby)
       
     assert_difference 'cart.cart_items.find_by(product_id: ruby_book.id).quantity' do
       cart.add_product(ruby_book.id).save
     end
  end
end
