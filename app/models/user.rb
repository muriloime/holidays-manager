class User < ActiveRecord::Base
  has_many :holidays , dependent: :destroy
  has_many :microposts , dependent: :destroy
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { self.login = self.login.downcase }
  validates :password, presence: true, length: {minimum: 6, maximum: 10}, if: :password
  validates :name, presence: true, length: { maximum: 50 }
  validates :login, presence: true , length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }


  def get_all_days_holidays_business
    holidays_sum = 0;
    holidays_confirmed = Holiday.where(status:"Confirmed", user_id: id)
    holidays_confirmed.each do |holiday|
      holidays_sum += holiday.get_days_total_business.to_i
    end
    return holidays_sum
  end

  def feed
    Micropost.where("user_id = ?", id)
  end

end
