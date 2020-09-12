class RegistrationMailer < ApplicationMailer
  default from: 'no-replay@gmail.com'

  def registration_mail(user)
    @user = user
    @url = "http://localhost:3000/users/#{@user.id}"
    mail(subject: "TEAM APPへの登録のご案内" ,to: @user.email)
  end
end
