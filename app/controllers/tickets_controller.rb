class TicketsController < ApplicationController



  def index
    @tickets = Ticket.all
  end

  def show
  end

  def print
  end

  def cancel
  end

  def destroy
  end
end
