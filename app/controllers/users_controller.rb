class UsersController < ApplicationController
	layout 'devise'
	before_action :authenticate_user!
	def profile
	end
end
