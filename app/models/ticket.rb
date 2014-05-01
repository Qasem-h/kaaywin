class Ticket < ActiveRecord::Base

	belongs_to :user
	has_many :bet_item_clones, dependent: :destroy


	#a ticket can be in the following statuses:
	#1. Pending : if any event has a nill or no result
	#2. Won: if all events have results that are not null and all betItems for this ticket are active( true)
	#3. Lost: if al events have resuts that are not null and anyone of the bet-items is false

	def derivedStatus
		# lets first get all the events to do this we need to:
		# 1. get all bet_item_clones for this ticket 
		# 2. then for each clone we need to trickle up to its bet through its bet_item
		# 3. the bets are placed in an array

		status = "Win"

		bet_item_clones = self.bet_item_clones # --we have all bet_item we can see if all are true or false

		bets = Array.new

		
		bet_item_clones.each do |bet_item_clone|
			bets.push(bet_item_clone.bet_item.bet) 
		end

		results = Array.new

		bets.each do |bet|
			results.push(bet.event.result) # -- we have all results we can see if any nill exists
			puts "result: " + bet.event.result
		end

		results.each do |result|
			if result.nil? or result.blank? or result == ""
				status = "Pending"  # if there is a pending result 
			end
		end
		puts "status after loop:" + status

		  if !(status.eql? "Pending")  # the ticket is either a winning or losing ticket now
		  	status = "Won"
		  	bet_item_clones.each do |clone|
		  		if !(clone.bet_item.active)
		  			status = "Lost"
		  		end
		  	end

		 end

		 return status
	end






end
