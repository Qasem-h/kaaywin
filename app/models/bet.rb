class Bet < ActiveRecord::Base
	has_many :bet_items, dependent: :destroy
	
	belongs_to :event
	belongs_to :bet_type
	accepts_nested_attributes_for :bet_items, :allow_destroy => true, :reject_if => :all_blank

end
