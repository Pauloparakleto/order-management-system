class OrdersController < ApplicationController
  def index
    @orders = Order.all.order(:order_number)
  end
end