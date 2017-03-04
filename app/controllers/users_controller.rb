class UsersController < ApplicationController
	layout 'devise'
	before_action :authenticate_user!
	before_action :clear_session, only: [:profile]
	
	def profile
	end

	def clear_session
    	session[:answers] = nil
  	end
end
