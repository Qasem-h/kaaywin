class UsersController < ApplicationController

  # only allow logged in users
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]

  #Only Allow Admin users to destroy
  before_action :permited_user_delete, only: [:destroy]

  before_action :permited_user_list, only: [:index]

  before_action :permited_user_edit, only: [:edit]
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
    #@user.role = params[:role]
  	if @user.save
  		flash[:success] = "User registered successfully"
  		redirect_to root_path
  		#
  		#
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "User updated"
      redirect_to users_url
    else
      render 'edit'
    end

  end


  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

 def permited_user_delete
  #only permit deleting of users if the logged in user is an admin or supervisor and logged in user has higher privilege than the deleted user and 
  # the logged in user is not the deleted user
    redirect_to(root_url) unless current_user.role_id <3 && (current_user.role_id <= User.find(params[:id]).role_id && current_user !=User.find(params[:id]))
  end

  def permited_user_list
  #only permit listing users if current user is an admit or supervisor
    redirect_to(root_url) unless current_user.role_id <3 
  end

  def permited_user_edit
  #only allow administrators and supervisors to edit
  # administrator can edit only their account and any supervisors
  # supervisors can only edit their account and any operator
  thisUser = User.find(params[:id])
 redirect_to(root_url) unless ((current_user.role_id<3 && current_user.role_id < thisUser.role_id) || (current_user.role_id < 3 &&current_user == thisUser))
    #
 
     
   end

private
	def user_params # to prevent mass assginement security vulnerabily
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_id)
	end

  def admin_user
    redirect_to(root_url) unless current_user.role == 1
  end


end
