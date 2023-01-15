class Admin::OrderDetailsController < ApplicationController
  def index
    @order_details = OrderDetail.all
    @order_informations = OrderInformation.all
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
    if @order_detail.update(order_detail_params)
      case @order_detail.production_status
        when "製作中"
          @order_detail.order_information.update(order_status: "製作中")
        when  "製作完了"
          if @order_detail.order_information.order_details.all?{|order_detail| @order_detail.production_status == "製作完了"}
            @order_detail.order_information.update(order_status: "発送準備中")
          end
      end
      flash[:inform] = "製作ステータスを更新しました"
    end
    redirect_to admin_order_information_path(@order_detail.order_information.id)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end

end