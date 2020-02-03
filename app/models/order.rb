class Order < ApplicationRecord
  enum delivery: { seven_eleven: 0, hilife: 1, ok_mart: 2, courier: 3 }
end
