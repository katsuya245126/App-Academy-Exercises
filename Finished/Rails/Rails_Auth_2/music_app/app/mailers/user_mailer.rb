class UserMailer < ApplicationMailer
  default from: 'verification@musicapp.com'

  def verification_email(user)
    @user = user
    @url = "/users/verify?verification_token=#{@user.verification_token}"

    mail(to: user.email, subject: 'Verify your email address')
  end
end
