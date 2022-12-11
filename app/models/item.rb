class Item < ApplicationRecord
  has_one_attached :image

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', current_type: 'image/jpeg')
    end
    image
  end

  belongs_to :genre
  enum is_active: { "販売中":true, "販売停止中":false}

end
