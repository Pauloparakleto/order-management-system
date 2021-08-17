class OrdersController < ApplicationController
  def index
    @orders = Order.all.order(:order_number)
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.create(order_params)
    if @order.valid?
      redirect_to orders_path(@order)
    else
      render new_order_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:product_name, :price)
  end
end