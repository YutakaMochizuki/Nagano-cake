class Admin::OrderInformationsController < ApplicationController
  def index
    @order_informations = OrderInformation.all
    @order_details = OrderDetail.all
  end

  def show
    @order_information = OrderInformation.find(params[:id])
    @order_details = @order_information.order_details
  end

  def update
    @order_information = OrderInformation.find(params[:id])
    @order_details = order_information.order_details
    if @order_information.update(order_information_params)
      flash[:inform] = "注文ステータスを更新しました"
    end
    @order_detail = OrderDetail.find(params[:id])
    redirect_to admin_order_information_path(@order_information.id)
  end

    private
  def order_information_params
    params.require(:order_information).permit(:order_status)
  end

end
