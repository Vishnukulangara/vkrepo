class Asset < ActiveRecord::Base
	validates :name, :asset_category, :asset_type, presence: true
end
