class BettingController < ApplicationController
  
	# # Author: Hussein Diab-Ghanem
	# Date: 9th April 2014
	# this controller will be responsible for all bet placing, ticket generation and ticket printing

  def index
  	@leagues= League.all
  	session[:betSlip] = nil
  	@front_office = true
  end

# actual bet placing that updates the betting slip session instance
  def placebet
  	@front_office = true
  	session[:betSlip] = BetSlip.new unless !session[:betSlip].nil?



  	betItem = BetItem.find(params[:id])
  	# get the event as we will need its name to avoid mulitple bets placed on the same
  	#event
  	event = betItem.bet.event

  	#add the bet
  	session[:betSlip].addPick(betItem.id,betItem.bet.name,event.name,betItem.name, betItem.odds)
  
  	puts(session[:betSlip].betItems)
  	puts(session[:betSlip].eventNames)
  	#puts(event.name)
 	
  	respond_to do |format|
  		format.html
  		format.js
  		end
  	end

  end

