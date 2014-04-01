class BetItem < ActiveRecord::Base
	belongs_to :bet
	validates :name, presence: true
	validates :odds, presence: true
	validates_numericality_of :odds

	before_save {self.odds = self.odds.to_f.round(2)}
	
end
