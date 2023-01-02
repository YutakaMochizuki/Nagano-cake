class OrderDetail < ApplicationRecord
  belongs_to :order_information
  belongs_to :item

  enum production_status: {制作待ち: 0, 製作中: 1, 制作完了: 2}

  after_update do
    order_details = self.order_information.order_details
    if order_details.any? {|order_detail|
       order_detail.item_status == 0} == true
       self.order_information.update(order_status: 1)
    elsif order_details.all? {|order_detail|
          order_detail.item_status == 1} == true
          self.order_information.update(order_status: 2)
    end
  end
end
