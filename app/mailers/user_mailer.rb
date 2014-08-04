class UserMailer < ActionMailer::Base
  default from: "no-reply@excitest.com"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
end