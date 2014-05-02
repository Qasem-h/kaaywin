class Transaction < ActiveRecord::Base

	# the model that keeps user money topups and consumption
	#

	belongs_to :user
	validates_numericality_of :amount
end
