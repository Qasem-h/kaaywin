class BetItem < ActiveRecord::Base
	belongs_to :bet
	has_one :result, through: :bet
end
