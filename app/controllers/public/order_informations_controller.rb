class Public::OrderInformationsController < ApplicationController
  def new
    @order_information = OrderInformation.new
    @addresses = current_customer.addresses.all
    @current_customer = current_customer
  end

  def create
    @order_information = OrderInformation.new(order_information_params)
    @cart_items = CartItem.all
    @order_information.customer_id = current_customer.id
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    @order_information.postage = 800
    @order_information.total_amount = 800+@total
    @order_information.save

  # order_detailへの保存
    current_customer.cart_items.each do |cart_item|
			@order_detail = OrderDetail.new
			@order_detail.order_information_id = @order_information.id
			@order_detail.item_id = cart_item.item.id
			@order_detail.amount = cart_item.amount
			@order_detail.production_status = 0
			@order_detail.price_including_tax = (cart_item.item.price * 1.1).floor
			@order_detail.save
		end

    CartItem.destroy_all
    redirect_to public_order_information_complete_path(@order_information)
  end

  def show
    @order_information = OrderInformation.find(params[:id])
    @order_details = OrderDetail.all
    @total =  @order_information.total_amount - @order_information.postage
  end

  def confirm
    @order_information = OrderInformation.new(order_information_params)
    @cart_items = CartItem.all
    @customer = current_customer

    # 支払方法
    if params[:payment_method] = OrderInformation.payment_methods.key(0)
      @order_information_payment_method = params[:peyment_method].to_i
    elsif params[:payment_method] = OrderInformation.payment_methods.key(1)
      @order_information_payment_method = params[:peyment_method].to_i
    end

    # 住所
    # 自身の住所を選択した場合
    if params[:order_information][:select_address] == '1'
		  @order_information.postal_code = @customer.postal_code
			@order_information.address = @customer.address
			@order_information.name = @customer.last_name + @customer.first_name
    # 登録済住所から選択した場合
    elsif params[:order_information][:select_address] == '2'
      @address = Address.find(params[:order_information][:address_id])
      @order_information.postal_code = @address.postal_code
			@order_information.address = @address.address
			@order_information.name = @address.name
    # 新しいお届け先を選択した場合
		elsif params[:order_information][:select_address] == '3'
			@order_information.postal_code= params[:order_information][:postal_code]
			@order_information.address= params[:order_information][:address]
			@order_information.name = params[:order_information][:name]
		end
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    @total_price = 800+@total
  end

  def complete
  end

  def index
    # @order_informations = OrderInformation.all
    @order_informations = current_customer.order_informations
  end

  def update
    @order_information = OrderInformation.find(params[:id])
    @order_details = @order_information.order_details
    if @order_information.update(order_information_params)
      flash[:inform] = "注文ステータスを更新しました"
    end
    @order_detail = OrderDetail.find(params[:id])
    redirect_to admin_order_information_path(@order_information)
  end

  private
  def order_information_params
    params.require(:order_information).permit(:customer_id, :name, :postal_code, :address, :payment_method, :order_status)
  end

  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :amount, :production_status, :price_including_tax)
  end

end