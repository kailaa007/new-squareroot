class AdminMailer < ApplicationMailer

  default from: "amitkumar@mobikasa.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin.admin_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail :to => @user[:email], :subject => "Password Reset"
  end
end
