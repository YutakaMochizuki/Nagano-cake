class OrderInformation < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
	enum payment_method: {credit_card: 0, transfer: 1}

	def sum_of_price
    item.with_tax_price * amount
  end
end