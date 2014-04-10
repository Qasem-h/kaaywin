class BetTypesController < ApplicationController

# Author: Hussein Diab-Ghanem
# Date: 10th April 2014
# 

 before_action :signed_in_user, only: [:index, :edit, :update, :destroy]

  before_action :admin_user, only: [:destroy, :new, :edit]

  def new
    @bet_type = BetType.new # create a blank bettype object 
  end

  def create
    @bet_type = BetType.new(user_params) # save the bet type
   
    if @bet_type.save
      flash[:notice] = "Bet Type successfully registered"
      redirect_to bet_types_url
    else
      render 'new'
    end

  end

  def edit # edit bet type details
    @bet_type = BetType.find(params[:id])
  end

  def update
    @bet_type = BetType.find(params[:id])
   
    if @bet_type.update_attributes(user_params) # get the protected user params
      flash[:success] = "Bet_type updated"
      redirect_to bet_types_url
    else
      render 'edit'
    end
  end


  def destroy
    BetType.find(params[:id]).destroy
    flash[:success] = "Bet Type successfully deleted"
    redirect_to bet_types_url
  end

  def index
    @bet_types = BetType.paginate(page: params[:page])
  end

  private
  def user_params # to prevent mass assginement security vulnerabily
    params.require(:bet_type).permit(:name)
  end
  def admin_user
    redirect_to(root_url) unless current_user.role_id <3
  end


end



