class AdminController < ApplicationController
  def index
  	@total_orders = Order.count
  	@user = User.find_by_id(session[:user_id])
  end
end
