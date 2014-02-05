class SessionsController < ApplicationController

	def new # a session is created everytime a user logs on, onlyee render the session for9 sign in pag

	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to user
		else
			flash.now[:error] = 'Invalid email/ password combination'
			render 'new'
		end

	end


	def destroy #  a session is deleted everytime a user logs out
		sign_out
		redirect_to root_url
	end

end
