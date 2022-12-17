class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.all
    @address.customer_id = current_customer.id
  end

  def create
    @address = Address.new(address_params)
    @address.save
    redirect_to public_addresses_path
  end

  def edit
  end

  def destroy
  end

  private
  def address_params
    params.require(:address).permit(:customer_id, :postal_code, :address, :name)
  end

end
