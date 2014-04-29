class Bet < ActiveRecord::Base
	has_many :bet_items, dependent: :destroy
	
	belongs_to :event
	belongs_to :bet_type
	accepts_nested_attributes_for :bet_items, :allow_destroy => true, :reject_if => :all_blank


	# lets define a method that will release the correct bet pick or bet item

	def correct
		bet_items = self.bet_items
		correct = " "
		self.bet_items.each do |bet_item|

			if bet_item.active?
				correct = bet_item.name
			end
		end

		return correct
	end



end
