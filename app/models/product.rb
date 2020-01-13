class Product < ApplicationRecord
  # Inside status
  # on:    上架
  # off:   下架
  # stock: 進貨中
  enum status: { off: -1, stock: 0, on: 1 }

  has_many_attached :pics
end
