class BetItem < ActiveRecord::Base
	belongs_to :bet
	validates :name, presence: true
	validates :odds, presence: true
	validates_numericality_of :odds
	has_many :bet_item_clones

	before_save {self.odds = sprintf "%.2f", self.odds.to_f}
	
end
