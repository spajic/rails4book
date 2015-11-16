require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  setup do
    @cart = carts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:carts)
  end

  test "should show proper cart page on fixture data" do
    get :show, id: carts(:cart_of_rubyst)
    assert_select 'td', /Ruby/, minimum: 1
  end

  test "should show quantity information in form 1x quantity" do
    get :show, id: carts(:cart_of_rubyst)
    assert_select 'td', /1x/
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cart" do
    assert_difference('Cart.count') do
      post :create, cart: {  }
    end

    assert_redirected_to cart_path(assigns(:cart))
  end

  test "should show cart" do
    get :show, id: @cart
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cart
    assert_response :success
  end

  test "should update cart" do
    patch :update, id: @cart, cart: {  }
    assert_redirected_to cart_path(assigns(:cart))
  end

  test "should destroy cart" do
    assert_difference('Cart.count', -1) do
      session[:cart_id] = @cart.id
      delete :destroy, id: @cart
    end

    assert_redirected_to store_path
  end
end
