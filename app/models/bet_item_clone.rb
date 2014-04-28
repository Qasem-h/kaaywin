class BetItemClone < ActiveRecord::Base

	# a bet_item clone is needed because odds value can change
	# we need to capture the odds value on the instant that ticket was issued
	# hence the need for a BetItemClone that will share all values of a bet_item except odds

	belongs_to :bet_item
	belongs_to :ticket

	before_save {self.odds = sprintf "%.2f", self.odds.to_f}
end
