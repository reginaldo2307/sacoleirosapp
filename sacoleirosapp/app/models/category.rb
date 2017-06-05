class Category < ActiveRecord::Base
	
	# Associations
	has_many :ads
	# Validates
	validates_presence_of :description

	#Scope
	scope :order_by_description, -> { order(:description) }
end
