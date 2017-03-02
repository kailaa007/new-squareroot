class UsersController < ApplicationController
	layout 'devise'
	before_action :authenticate_user!
	before_action :clear_session, except: [:set_birth_plan, :index, :send_email_report]
	
	def profile
	end

	def clear_session
    	session[:answers] = nil
  	end
end
