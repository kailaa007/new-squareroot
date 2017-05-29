class UserMailer < ApplicationMailer
	default from: "amitkumar@mobikasa.com"

	def send_report(user)
    	@user = user
    	@birth_plan_answers = @user.birth_plan_answers
    	mail(to: @user.email, subject: 'Your Report')
  	end
end

