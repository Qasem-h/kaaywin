
# Author: Hussein Diab-Ghanem
# Date: 9th April 2014
# Description: this class will be used to encapsulate a betting slip instance.
# webusers will use this class to simulate placing bets.
# tellers will use this class to place bets and thus generate tickets once committed to th database


class BetSlip 
	@totalBets = 0
	@stake = 20 # this is the minumum stake
	@possibleWinning = 0
	@totalOdds = 0
	@picks = Hash.new
	@betNames = Array.new # you wanna keep this to avoid the same bet being placed twice
	attr_reader :picks
	attr_reader :betItems
	attr_reader :betNames
	@betItems

	def initialize()
		@picks = Hash.new 
		@betItems = Array.new
		@betNames = Array.new
	end
	# method that is used to hold clicked picks 
	def addPick(title, odds)
		success = true
		if @picks.length == 0
			@picks = {title => odds}
		else
			if (@picks[title].nil?)  # if this pick has not already been added don't add it
				
				@picks[title] = odds

			else
				
				success = false
			end
		end

		
		return success

	end

	# method that is used to store the bet_item corresponding to the clicked odds

	def addBetItem(id)
		@betItems.push(id) unless !(@betItems.index(id).nil?)
	end

	def addBetName(name)
		@betNames.push(name) unless !(@betNames.index(name).nil?)
	end





end
