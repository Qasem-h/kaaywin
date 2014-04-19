
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
	@picks_id = Array.new # hold the picks selected by the user
	@picks_name = Array.new 
	@picks_odds = Array.new 
	@betNames = Array.new # you wanna keep this to print next to the event
	@eventName = Array.new # you will use the ev
	attr_reader :picks_id
	attr_reader :picks_name
	attr_reader :picks_odds
	
	attr_reader :betNames  # used to print bet names 
	attr_reader :eventNames
	attr_reader :stake

	attr_writer :stake




	def initialize()
		@picks_id = Array.new 
	    @picks_odds = Array.new 
		@betNames = Array.new
		@eventNames = Array.new
		@picks_name = Array.new 
		@stake = 20
	end

def addPick(betItemID, betItemName,betItemOdds,betName,eventName)
		if @picks_id.length == 0    # if this is the first bet being placed just push it in
			@picks_id.push(betItemID)
			@picks_name.push(betItemName)
			@picks_odds.push(betItemOdds)	
				addBetName(betName)
				addEventName(eventName)
		else
			if (@eventNames.index(eventName).nil?)  # if this event name has never been added
				
				@picks_id.push(betItemID)
			    @picks_name.push(betItemName)
			    @picks_odds.push(betItemOdds)	
			
				addBetName(betName)
				addEventName(eventName)

			else
				
				success = false
			end
		end

		
		return success

	end

	def totalOdds
		result =1
		@picks_odds.each {|odd| result = result*odd.to_f}
		result = sprintf "%.2f", result.to_f
		result = result.to_f
		return result
	end


	def addBetName(name)
		@betNames.push(name) #unless !(@betNames.index(name).nil?)
	end

    def addEventName(name) # we need to hold  them so that aa user cannot bet twice on the same event
    	@eventNames.push(name) #unless !(@eventNames.index(name).nil?)
    end

    def winnings
    	 (sprintf "%.2f",(@stake*totalOdds)).to_f
    end


    def removeBet(index)
    	@picks_id.delete_at(index)
	    @picks_odds.delete_at(index)
		@betNames.delete_at(index)
		@eventNames.delete_at(index)
		@picks_name.delete_at(index)
    end


    def reset
    	initialize()
    end


end
