class BetItem < ActiveRecord::Base
	belongs_to :bet
	validates :name, presence: true
	validates :odds, presence: true
	validates_numericality_of :odds
	
end
