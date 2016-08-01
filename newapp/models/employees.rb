class Employee < ActiveRecord::Base
  has_one :employer

  validates :name, :email, :address, :date_of_birth, :date_of_joining, :employment_status, :section, presence: true
  validates :email, uniqueness: true
end
