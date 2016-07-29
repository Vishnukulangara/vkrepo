class Employer < ActiveRecord::Base
	
	include BCrypt
	has_secure_password

	validates :password, confirmation: true
  	validates :password_confirmation, presence: true
  	validates :name, :email, :company_name, :password,   presence: true
  	validates :password, length: {minimum: 6}
  	validates :email, :company_name, uniqueness: true
end