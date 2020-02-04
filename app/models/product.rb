class Product < ApplicationRecord
  before_save :product_information

  enum status: { on_shelves: 0, stock: 1, off_shelves: -1 }

  has_many_attached :pics, dependent: :destroy
  belongs_to :user

  validates_presence_of :name

  validates :pics, content_type: ['image/png', 'image/jpg', 'image/jpeg']

  private

  # SKU 商品編號：通常表示規格、顏色、款式
  def product_information
    serial_num = (0...5).map { ('A'..'z').to_a[rand(26)] }.join

    self.sku = "#{Time.current.to_i}#{serial_num}"
  end
end
