class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def create
    @cart_item = CartItem.new(cart_item_params)
    @customer = current_customer
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to public_cart_items_path
  end

  def index
    @cart_items = CartItem.all

  end

  def show
  end

  def edit
  end

  def destroy
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :amount)
  end

end
