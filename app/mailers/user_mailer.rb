class UserMailer < ActionMailer::Base
  default from: "raresapp@rares.com", reply_to: "raresapp@rares.com"
  layout "mail"

  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Sign Up Confirmation"
  end

  def reset_password(user)
    @user = user
    mail to: user.email, subject: "Reset Password"
  end

end
