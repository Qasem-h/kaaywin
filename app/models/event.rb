class Event < ActiveRecord::Base
	validates :name, presence: true
	validates :date, presence: true
	belongs_to :event
	has_many :bets
end
