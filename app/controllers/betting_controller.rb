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

    if session[:current_card] # if a scratch-card is verified update the betSLip
      session[:betSlip].stake = session[:current_card].credit
    end
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

      # lets update the transactions table with what this user just spent
      # but we need to decide if this was a scratch card transaction or
      # regular one

      if !session[:current_card]  # this is a regular logged in user
        if current_user.balance >= session[:betSlip].stake
          Transaction.create(amount: session[:betSlip].stake.to_f*-1, user_id: current_user.id, transaction_type: 1, comment: 'web entry')
  		   # return the ticket for printing
         @ticket = session[:betSlip].createTicket_for_user(current_user.id)
  
        else 
          flash.now[:warning] = "insufficient balance"
          
        end
      else  # this has to be a scratch card
         # return the ticket for printing
          @ticket = session[:betSlip].createTicket_for_card(session[:current_card].id)
          session[:current_card].status = 2  # set the card to used
          session[:current_card].save  
          sign_out_card  # sign the card out as its been used
      end
        session[:betSlip].reset
  		respond_to do |format|
  			format.html
  			format.js
  		end

  	end

 # this method is invoked only when the user signs in from the front end
    def front_signin
          user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          sign_in user
      
        else
         flash.now[:error] = 'Invalid email/ password combination'
      
        end
        redirect_to action: 'index'
    end

    # this method is invoked only when the user signs out from the front end
    def front_signout 
      sign_out
      redirect_to action: 'index'
    end
  end

