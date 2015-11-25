require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:ruby)
  end

  test "should get index for admin" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should redirect to login page for not admin" do
    logout
    get :index
    assert_redirected_to login_url
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { 
        description: @product.description, 
        image_url: @product.image_url, 
        price: @product.price, 
        title: 'unique title' }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: { description: @product.description, image_url: @product.image_url, price: @product.price, title: @product.title }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product that is not in any cart" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: products(:two)
    end

    assert_redirected_to products_path
  end
end
