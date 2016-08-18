class Employee < ActiveRecord::Base
	validates :email, :name, :date_of_joining, :employment_status, presence: true
	validates :email, uniqueness: true
end
