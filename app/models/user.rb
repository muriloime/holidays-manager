class User < ActiveRecord::Base
  validates :password, length: { maximum: 10 }
  has_many :holidays
end
