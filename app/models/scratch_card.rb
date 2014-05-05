class ScratchCard < ActiveRecord::Base

	validates_uniqueness_of :hidden_number


	#generate a single scratchcard and 
	def self.generate(denomination)
		ScratchCard.create(credit: denomination, hidden_number: rand.to_s[2..16], status: 0)
	end


	#a scratch card is deemed verified if its hidden number exists and its status = 1( printed)

	def self.verify(hidden_number)
		
		card = ScratchCard.where("hidden_number = ?  AND status = ?", hidden_number, 1) # this means that the card is activated or in the marke
		 
		 if card.blank? 
		 	return false
		 else
		 	return true
		 end
	end

		


end
