class User < ActiveRecord::Base
  has_many :holidays , dependent: :destroy
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { self.login = self.login.downcase }
  validates :password, presence: true, length: {minimum: 6, maximum: 10}, on: :create
  validates :name, presence: true, length: { maximum: 50 }
  validates :login, presence: true , length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }


end
