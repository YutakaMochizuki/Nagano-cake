class OrderInformation < ApplicationRecord
  belongs_to :customer
  has_many :order_details

  enum order_status: {入金待ち:0, 入金確認:1, 製作中:2, 発送準備中:3, 発送済み:4}
	enum payment_method: {credit_card: 0, transfer: 1}

	def sum_of_price
    item.with_tax_price * amount
  end

  after_update do
    if self.order_status == 2
      self.order_details.each {|order_detail|
      order_detail.update(production_status: 2)
      }
    end
  end

end