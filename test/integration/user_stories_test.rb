require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
	fixtures :products
  	
=begin
	Пользователь заходит на страницу каталога магазина.
	Он добавляет товар с корзину.
	Затем он оформляет заказ, заполняя форму заказа.
	Затем он отправляет данные формы заказа.
	В БД создаётся заказ, содержащий информацию о пользователе и 
	  о заказанной товарной позиции.
	При получении заказа отправляется email-оповещение клиенту.  	
=end
  	test "buy a product" do
  		CartItem.delete_all
  		Order.delete_all
  		ruby_book = products(:ruby)

  		# Пользователь заходит на страницу каталога магазина.
  		get "/"
  		assert_response :success
  		assert_template "index"

  		# Он добавляет товар с корзину.
  		xml_http_request :post, '/cart_items', product_id: ruby_book.id
  		assert_response :success

  		cart = Cart.find(session[:cart_id])
  		assert_equal 1, cart.cart_items.size
  		assert_equal ruby_book, cart.cart_items[0].product

  		# Затем он оформляет заказ, заполняя форму заказа.
  		get "/orders/new"
  		assert_response :success
  		assert_template "new"

		# Затем он отправляет данные формы заказа.
  		post_via_redirect "/orders",
  			order: {
  				name: "Alex",
  				address: "Moscow",
  				email: "bs@gmail.com",
  				pay_type: "Check"	
  			}
  		assert_response :success
  		assert_template "index"
  		cart = Cart.find(session[:cart_id])
		assert_equal 0, cart.cart_items.size  		

		# В БД создаётся заказ, содержащий информацию о пользователе и 
	    #   о заказанной товарной позиции.
	    orders = Order.all
	    assert_equal 1, orders.size
	    order = orders[0]

	    assert_equal "Alex", order.name
	    assert_equal "Moscow", order.address
	    assert_equal "bs@gmail.com", order.email
	    assert_equal "Check", order.pay_type

	    # При получении заказа отправляется email-оповещение клиенту. 
	    mail = ActionMailer::Base.deliveries.last
	    assert_equal ["bs@gmail.com"], mail.to
	    assert_equal ["bestspajic@gmail.com"], mail.from
	    assert_equal 'Подтверждение заказа в rails4book', mail.subject
  	end
end
