class LoginHistory < ActiveRecord::Base
	belongs_to :logger
	#self.per_page = 5
end