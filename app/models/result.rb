class Result < ActiveRecord::Base
	belongs_to :event
	has_many :bets, through: :event
	has_many :bet_items, through: :bets
	accepts_nested_attributes_for :bets
end
