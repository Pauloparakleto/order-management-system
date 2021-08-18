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
      flash[:notice] = "Order created!"
      redirect_to orders_path(@order)
    else
      flash[:alert] = @order.errors.full_messages
      redirect_to new_order_path
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "Updated!"
      redirect_to orders_path
    else
      flash[:alert] = @order.errors.full_messages
      redirect_to edit_order_path(@order)
    end
  end

  private

  def order_params
    params.require(:order).permit(:product_name, :price, :status)
  end
end