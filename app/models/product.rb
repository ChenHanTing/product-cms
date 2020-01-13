class Product < ApplicationRecord
  # Inside status
  # on:    上架
  # off:   下架
  # stock: 進貨中
  enum status: { stock: 0, on_shelves: 1, off_shelves: -1 }

  has_many_attached :pics, dependent: :destroy
  belongs_to :user

  validates_presence_of :name

  validates :pics, content_type: ['image/png', 'image/jpg', 'image/jpeg']
end
