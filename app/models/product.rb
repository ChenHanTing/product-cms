class Product < ApplicationRecord
  enum status: { on_shelves: 0, stock: 1, off_shelves: -1 }

  has_many_attached :pics, dependent: :destroy
  belongs_to :user

  validates_presence_of :name

  validates :pics, content_type: ['image/png', 'image/jpg', 'image/jpeg']
end
