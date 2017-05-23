class SessionsController < Devise::SessionsController 
	respond_to :html, :js	

	def create
		self.resource = warden.authenticate!(auth_options)
		set_flash_message(:notice, :signed_in) if is_navigational_format?
		sign_in(resource_name, resource)
		if !session[:return_to].blank?
			redirect_to session[:return_to]
			session[:return_to] = nil
		else
			respond_with resource, :location => after_sign_in_path_for(resource)
		end
	end

	def new
		@user_ = User.find_by(email: params[:user][:email])
		self.resource = resource_class.new(sign_in_params)
	    clean_up_passwords(resource)
	    yield resource if block_given?
	    respond_with(resource, serialize_options(resource))
	end
	def after_sign_in_path_for(resource)
		profile_path
	end
	
end
