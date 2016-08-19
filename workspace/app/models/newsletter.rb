class Newsletter < ActiveRecord::Base
	serialize :sent_to, Array 
end
