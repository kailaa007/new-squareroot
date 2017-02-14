class RegistrationsController < Devise::RegistrationsController
  respond_to :json  
  	def after_sign_up_path_for(resource)		
		profile_path
	end

	# The path used after sign up for inactive accounts.
	def after_inactive_sign_up_path_for(resource)	
		birth_plans_path
	end
end
