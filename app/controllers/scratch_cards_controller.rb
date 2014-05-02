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


end
