class UsersController < ApplicationController

  # only allow logged in users
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]

  #Only Allow Admin users to destroy
  before_action :admin_user, only: :destroy
  def new
  	@user = User.new
  end

  
  def index  # will list all users in the system
    @users = User.paginate(page: params[:page])
  end

  def register  # this method will be used by administror
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(user_params)
    @user.role = params[:role]
  	if @user.save
  		flash[:success] = "User registered successfully"
  		redirect_to root_path
  		#
  		#
  	else
  		render 'new'
  	end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end



private
	def user_params # to prevent mass assginement security vulnerabily
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
	end

  def admin_user
    redirect_to(root_url) unless current_user.role == 1
  end


end
