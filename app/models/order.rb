class Order < ApplicationRecord
  before_save :order_information

  has_many :items

  validates_presence_of :number

  enum delivery: { seven_eleven: 0, hilife: 1, ok_mart: 2, courier: 3 }

  private

  def order_information
    # 訂單號碼
    serial_num = (0...5).map { ('A'..'z').to_a[rand(26)] }.join

    self.code = "order_#{Time.current.to_i}#{serial_num}"

    # 加上運費
    return self.price += 60 if delivery.eql?('seven_eleven' || 'hilife')

    return self.price += 30 if delivery.eql?('ok_mart')

    self.price += 100
  end
end
