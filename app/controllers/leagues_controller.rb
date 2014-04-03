class LeaguesController < ApplicationController

 before_action :signed_in_user, only: [:index, :edit, :update, :destroy]

  before_action :admin_user, only: [:destroy, :edit, :new]

  def new
  	@league = League.new # create a blank league object to give to the league form
  end

  def create
  	@league = League.new(user_params) # save the league
  
  	if params[:league][:active]=="yes"
  		@league.active = true;
  	end
  	if params[:league][:active]=="no"
  		@league.active = false
  	end	
  	if @league.save
  		flash[:notice] = "League successfully registered"
  		redirect_to leagues_url
  	else
  		render 'new'
  	end

  end

  def edit # edit league details
  	@league = League.find(params[:id])
  end

  def update
  	@league = League.find(params[:id])
  	if params[:league][:active]=="yes"
  		@league.active = true;
  	end
  	if params[:league][:active]=="no"
  		@league.active = false
  	end	
  	if @league.update_attributes(user_params)
  		flash[:success] = "League updated"
  		redirect_to leagues_url
  	else
  		render 'edit'
  	end
  end





  def destroy
  	League.find(params[:id]).destroy
  	flash[:success] = "League successfully deleted"
  	redirect_to leagues_url
  end

  def index
    @leagues = nil;
    @league = League.first
    if params[:id].nil?  # if the user intended to list ALL leagues
  	   @leagues = League.all
     else  # the user selected a sport and needs to list its leagues
      @leagues = Sport.find(params[:id]).leagues
  
    end

    respond_to do |format|
      format.js
      format.html
    end
   
  end

  private
	def user_params # to prevent mass assginement security vulnerabily
		params.require(:league).permit(:name, :country, :comments, :sport_id )
	end


  def admin_user
    redirect_to(root_url) unless current_user.role_id < 3
      end

end
