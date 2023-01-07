class Admin::OrderDetailsController < ApplicationController
  def index
    @order_details = OrderDetail.all
    @customers = Customer.all
    @items = Item.all
  end

  def show
    @order_detail = OrderDetail.find(params[:id])
    @order_details = OrderDetail.all
  end

  def edit
    @order_detail = OrderDetail.find(params[:id])
  end

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    redirect_to order_detail_path(@order_detail.id)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end

end
