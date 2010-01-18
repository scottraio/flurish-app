module LoginSystem

	def authenticated?
		return true unless current_user.nil?
	  case self.interface
	    when :standard_login then self.authenticate_via_form
		else
			access_denied
	  end
	end
	
	def interface
	 	#if unauthorized_guest_request? then :guest_login
	  #else  :standard_login 
	  #end
		:standard_login if login_attempt? 
	end

	def authenticate_via_form
	  self.current_user ||= User.authenticate(@login, @password) || nil
		log_them_in
	end

	def authenticate_with_http
	  # Rails Specific
		basic_authentication("Flurish requires authentication") do |username, password| 
			authenticate(username,password)
		end
	end

	def access_denied
		flash[:error] = "Access Denied" if login_attempt?
		render :template => "users/login"
	end
	
	def log_them_in
		if logged_in? 
			puts "Logged in successful"
			redirect_to request.url
		else
			access_denied
		end
	end

	# Misc Helper Methods for Autheticating and setting the user's session

	def login_attempt? 
		if params[:user] && (not params[:user][:login].nil? and not params[:user][:password].nil?)
			credentials
			return true 
		else
			return false
		end
  end

	def credentials
		@login, @password = params[:user][:login], params[:user][:password]
	end

  def logged_in?
  	return true unless current_user.nil? 
  end
  
  def current_user
    @current_user ||= session[:user]
  end
  
  def current_user=(user)
		session[:user] = user
  end

  
end