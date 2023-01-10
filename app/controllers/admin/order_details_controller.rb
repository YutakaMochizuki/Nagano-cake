class Admin::OrderDetailsController < ApplicationController
  def index
    @order_details = OrderDetail.all
    @customers = Customer.all
    @items = Item.all
  end

  def show
    @order_detail = OrderDetail.find(params[:id])
    @order_details = OrderDetail.all
    @order_information = OrderInformation.find(params[:id])
  end

  def edit
    @order_detail = OrderDetail.find(params[:id])
  end

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_information = OrderInformation.find(params[:id])
    if @order_detail.update(order_detail_params)
      flash[:inform] = "更新しました"
    end
    redirect_to admin_order_detail_path(@order_detail.id)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:production_status, :order_status)
  end

end