class SportsController < ApplicationController
 before_action :signed_in_user, only: [:index, :edit, :update, :destroy]

  before_action :admin_user, only: [:destroy, :new, :edit]

  def new
    @sport = Sport.new # create a blank sport object to give to the sport form
  end

  def create
    @sport = Sport.new(user_params) # save the sport
   
    if @sport.save
      flash[:notice] = "Sport successfully registered"
      redirect_to sports_url
    else
      render 'new'
    end

  end

  def edit # edit sport details
    @sport = Sport.find(params[:id])
  end

  def update
    @sport = Sport.find(params[:id])
   
    if @sport.update_attributes(user_params) # get the protected user params
      flash[:success] = "Sport updated"
      redirect_to sports_url
    else
      render 'edit'
    end
  end


  def destroy
    Sport.find(params[:id]).destroy
    flash[:success] = "Sport successfully deleted"
    redirect_to sports_url
  end

  def index
    @sports = Sport.paginate(page: params[:page])
  end

  private
  def user_params # to prevent mass assginement security vulnerabily
    params.require(:sport).permit(:name)
  end
  def admin_user
    redirect_to(root_url) unless current_user.role_id <3
  end


end
