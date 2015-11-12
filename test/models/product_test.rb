require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test "product attributes must not be empty" do
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:price].any?
  	assert product.errors[:image_url].any?
  end

  test "product price must be >= $0.01" do
  	product = Product.new(
  	  title: "title",
  	  description: "desc",
  	  image_url: "img.png",
  	  price: 1)
  	assert product.valid?

  	product.price = -1
  	assert product.invalid?

  	product.price = 0
  	assert product.invalid?

  	product.price = 0.0001
  	assert product.invalid?
  end

  test "image_url must have image extension: gif, jpg, png" do
  	ok = %w{ fred.gif fred.jpg fred.PNG Fred.Jpg Fred.GIF 
  		http://a.b.c/fred/fred.png}

  	bad = %w{ fred.doc fred.gif/more fred.jpg.more }

  	ok.each do |name|
  	  assert Product.new(title: 't', description: 'd', price: 1, 
  	  	image_url: name).valid?
  	end

	bad.each do |name|
  	  assert Product.new(title: 't', description: 'd', price: 1, 
  	  	image_url: name).invalid?
  	end  	
  end

  test "product is not valid without unique name" do
  	product = Product.new(
  		title: products(:ruby).title, #existing title from fixture
  		description: 'd',
  		price: 1,
  		image_url: 'fred.gif'
  	)
  	assert product.invalid?
  	assert_equal ["has already been taken"], product.errors[:title]
  end
end
