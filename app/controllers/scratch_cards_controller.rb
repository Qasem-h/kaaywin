class ScratchCardsController < ApplicationController

# Author: Hussein Diab-Ghanem
# Description : the contoller that handles all CRUDs for scratch cards
# a scratch card allow a web user or SMS user to issue him or herself tickets by placing bets
# the card number is always used later as reference and proof of winnings

	def index
		@cards = ScratchCard.all
	end

	def generate_cards  # render the form so users can enter generation details
	end

	
	# perform the actual generation
	def generate
		(1..params[:quantity].to_i).each do |card|
			ScratchCard.generate(params[:denom])
		end
		flash[:success] = "sucessfully generated #{params[:quantity]} cards."
		redirect_to scratch_cards_path
	end

	def destroy
		ScratchCard.find(params[:id]).destroy
		flash[:success] = "Scratch Card sucessfully deleted."
		redirect_to scratch_cards_path
	end


	# when a card is printed we set its status to 1 
	# then do the actuall PDF printing
	def print_card
		card = ScratchCard.find(params[:id])
		card.status = 1  # status = 1 means printed

		if card.save
			flash[:success] = 'Card printed sucessfully'
			redirect_to scratch_cards_path
		else
			flash[:error]
			redirect_to :back
		end
	end

	# this method is used to verify a card and will thus use the session helper to set
	# the card_verified status to true

	# when a scratch card is verified its almost like a logged-in user
	# session environment needs to be updated
	# we also need to update the betSlips Stake
	def verify_card

		card = ScratchCard.find_by hidden_number: params[:hidden_number]

		if ScratchCard.verify(params[:hidden_number])
			sign_in_card(card)
			flash.now[:success] = "card sucessfully verified. You can place your bets!"
			
		else
			flash.now[:success] = "card sucessfully verified. You can place your bets!"

		 
	   end
	   redirect_to action: 'index', controller: 'betting'
	end

	def unverify_card
		sign_out_card
		redirect_to action: 'index', controller: 'betting'
	end


end
