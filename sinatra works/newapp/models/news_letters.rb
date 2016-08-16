class NewsLetter < ActiveRecord::Base
	serialize :recipients, Array 
end