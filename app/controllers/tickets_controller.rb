class TicketsController < ApplicationController



  def index
    @tickets = Ticket.all
  end

  # to display a ticket we will need to also get all the betItemClones
  # so we display 2 tables in the view
  # 1. for the basic ticket details present in the index page
  # 2  for the detailed ticket info 
  def show
    @ticket = Ticket.find(params[:id])
  
  end

  def print
  end

  def cancel
  end

  def destroy
    Ticket.find(params[:id]).destroy
    flash[:success] = "Ticket successfully deleted"
    redirect_to tickets_url
  end
end
