class BettingController < ApplicationController
  
	# # Author: Hussein Diab-Ghanem
	# Date: 9th April 2014
	# this controller will be responsible for all bet placing, ticket generation and ticket printing

  def index
  	@leagues= League.all
  	session[:betSlip] = nil
  end

# actual bet placing that updates the betting slip session instance
  def placebet
  	session[:betSlip] = BetSlip.new unless !session[:betSlip].nil?



  	betItem = BetItem.find(params[:id])

  	session[:betSlip].addPick(betItem.name, betItem.odds)
  	session[:betSlip].addBetItem(params[:id])
  	session[:betSlip].addBetName(BetItem.find(params[:id]).bet.name)
  	
  	puts(session[:betSlip].betItems)
  	puts(session[:betSlip].betNames)
 	
  	respond_to do |format|
  		format.html
  		format.js
  		end
  	end

  end

