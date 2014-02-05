class Bet < ActiveRecord::Base
	has_many :bet_items
	belongs_to :event
end
