class Logger < ActiveRecord::Base
	has_many :login_histories
	include BCrypt
	has_secure_password

  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :first_name, :email, :mobile_no, :password ,presence: true
  validates :password, length: {minimum: 6}
  validates :email, :mobile_no, uniqueness: true

end
