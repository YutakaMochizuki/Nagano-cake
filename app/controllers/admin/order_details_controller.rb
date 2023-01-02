class Admin::OrderDetailsController < ApplicationController
  def index
    @order_details = OrderDetail.all
    @customers = Customer.all
    @items = Item.all
  end

  def show
  end

  def edit
  end
end
