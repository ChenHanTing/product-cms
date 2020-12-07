class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #

  has_many :products
  has_many :fav_products
  has_many :collected_products, through: :fav_products, source: :product
  has_many :orders

  after_create :create_discount

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :login

  # 建使用者的同時，連優惠券一起建立
  def create_discount
    Discount.create!(user_id: self.id)
  end

  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end

  enum gneder: { female: 0, male: 1 }
end
