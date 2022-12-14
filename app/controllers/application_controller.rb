class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
      admin_items_path
    else
      public_items_path
    end
  end


  def after_sign_out_path_for(resource)
    new_customer_session_path
  end

  def current_cart
    Item.find(session[:item_id])
  rescue ActiveRecord::RecordNotFound
    item = Item.create
    session[:item_id] = item.id
    item
  end

protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :encrypted_password])
  end

  def setup_cart_item!
    @cart_item = current_cart.cart_items.find_by(item_id: params[:item_id])
  end

end
