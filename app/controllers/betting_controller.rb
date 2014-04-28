class BettingController < ApplicationController
  
	# # Author: Hussein Diab-Ghanem
	# Date: 9th April 2014
	# this controller will be responsible for all bet placing, ticket generation and ticket printing

  def index
  	@leagues= League.all
  	session[:betSlip] = nil
  	@emptySlip = true
  	@front_office = true
  end

  def test_image
  end


  # actual bet placing that updates the betting slip session instance
  def placebet
  	@front_office = true
  	session[:betSlip] = BetSlip.new unless !session[:betSlip].nil?
  	@emptySlip = false
  

  	betItem = BetItem.find(params[:id])
  	# get the event as we will need its name to avoid mulitple bets placed on the same
  	#event
  	event = betItem.bet.event

  	#add the bet to the slip together will all dta needed for rendering
  	# i.e the event name, pick, odds, etc
  	# we will also need to store the bet item to clone it later on 
  	session[:betSlip].addPick(betItem.id, betItem.name,betItem.odds,betItem.bet.bet_type.name, event.name)
  
  	#puts(session[:betSlip].picks)
  	puts(session[:betSlip].eventNames)
  	#puts(event.name)
 	
  	respond_to do |format|
  		format.html
  		format.js
  		end
  	end

  	def remove_bet

  		# get the bet array index so we can remove it	
  		session[:betSlip].removeBet(params[:id].to_i)
  		respond_to do |format|
  			format.html
  			format.js
  		end
  	end

  	# the user updated the stae amount
  	def update_stake
  		session[:betSlip].stake = params[:amount].to_f

  		respond_to do |format|
  			format.html
  			format.js
  		end
  	end

  	def reset_bet_slip # used to clear all bets
  		session[:betSlip].reset
  		respond_to do |format|
  			format.html
  			format.js
  		end
  	end

  	def issue_ticket # issue the ticket
  		session[:betSlip].createTicket_for_user(current_user.id)
  		session[:betSlip].reset
  		respond_to do |format|
  			format.html
  			format.js
  		end
  	end
  end

