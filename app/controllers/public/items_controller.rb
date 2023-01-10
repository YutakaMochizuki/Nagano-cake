class Public::ItemsController < ApplicationController
   before_action :setup_cart_item!, only: [:add_item, :update_item, :delete_item]
  def index
    @items = Item.all.page(params[:page]).per(3)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active)
  end

end
