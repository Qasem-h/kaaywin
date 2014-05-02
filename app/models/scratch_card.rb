class ScratchCard < ActiveRecord::Base

	validates_uniqueness_of :hidden_number


	#generate a single scratchcard and 
	def self.generate(denomination)
		ScratchCard.create(credit: denomination, hidden_number: rand.to_s[2..16], status: 0)
	end


end
