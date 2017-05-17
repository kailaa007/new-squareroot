class UsersController < ApplicationController
	layout 'devise'
	before_action :authenticate_user!
	before_action :clear_session, only: [:profile]
	
	def profile
		redirect_to set_birth_plan_path if current_user.birth_plan_answers.blank?
	end

	def clear_session
    	session[:answers] = nil
  	end
end
