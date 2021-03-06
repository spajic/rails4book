require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
  
  test "should assign instance variable '@products'" do
    get :index
    assert_not_nil assigns(:products)
  end

  test "should get properly rendered store/index view" do
    get :index
    assert_select 'h3', 'Programming Ruby 1.9'
    assert_select '.entry', minimum: 3
    assert_select '.price', minimum: 3
  end

  test "should have button 'Add to Cart'" do
    get :index
    assert_select 'input[value="Add to Cart"]', minimum: 3
  end

  test "should get properly rendered price with $" do
    get :index
    assert_select '.price', /\$[\d]+\.\d\d/
  end

  test "should get properly rendered store/index view inside app layout" do
    get :index
    assert_select '#main .entry', minimum: 3
    assert_select '#columns #side a', minimum: 2
  end

  test "markup needed to store.js.coffe is in place" do
    get :index
    assert_select '.store .entry > img', minimum: 3
    assert_select '.entry input[type=submit]', minimum: 3
  end

  test "should contain button 'Checkout'" do
    get :index
    assert_select 'input[value=Checkout]'
  end
end
