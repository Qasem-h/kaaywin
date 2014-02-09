class Event < ActiveRecord::Base
	validates :name, presence: true
	validates :date, presence: true
	belongs_to :league
	has_many :bets
	accepts_nested_attributes_for :bets, :allow_destroy => true, :reject_if => :all_blank

end
