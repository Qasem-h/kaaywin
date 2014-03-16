class BetsController < ApplicationController

	 before_action :admin_user, only: :destroy
  def destroy

    # get the event to redirect back
    bet = Bet.find(params[:id])
    event_id = bet.event_id
    
  	bet.destroy
  	redirect_to event_path(event_id)
  end

  def create
  dgshsc 
  end



  private
	
  def user_params # to prevent mass assginement security vulnerabily
    params.require(:bet).permit(:name, :bet_type, :bet_items )
  end

  def admin_user
    redirect_to(root_url) unless current_user.role == 1
  end
end
