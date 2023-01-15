class OrderDetail < ApplicationRecord
  belongs_to :order_information
  belongs_to :item

  enum production_status: {着手不可:0, 制作待ち: 1, 製作中: 2, 製作完了: 3}

  after_update do
    order_details = self.order_information.order_details
    if order_details.any? {|order_detail|
      order_detail.production_status == 2} == true
      self.order_information.update(order_status: 2)
    elsif order_details.all? {|order_detail|
          order_detail.production_status == 3} == true
          self.order_information.update(order_status: 3)
    end
  end
end