class Event < ActiveRecord::Base
	validates :name, presence: true
	validates :date, presence: true
	belongs_to :league
	has_many :bets,dependent: :destroy
	has_many :bet_items, through: :bets
	
	
	accepts_nested_attributes_for :bets, :allow_destroy => true, :reject_if => :all_blank



	# search for all events that have already been played
	def self.been_played(league)
		find(:all,:conditions => ['league_id = ? and date <= ?', league, Time.now])
	end

	# search for all events that have been played but results not entered
	def self.played_not_entered 
		find(:all,:conditions => ['date <= ? and (result =? or result is null)' ,Time.now,""])
	end




end
