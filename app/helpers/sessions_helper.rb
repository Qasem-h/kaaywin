module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token]  = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end


	def current_user=(user)    #used to assign current_user to the signed in user
		@current_user = user
	end

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])  # get the remember token from the browser

		@current_user  ||= User.find_by(remember_token: remember_token) #only query the database the first time
	end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end
	# Store the url the subscriber was trying to access before being re-directed to sign in
	def store_location
    	session[:return_to] = request.url if request.get?
  	end


     def current_user?(user) # check if current user is equal to a particluar user
    	user == current_user
  	end

  	def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

end
