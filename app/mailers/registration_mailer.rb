class RegistrationMailer < ApplicationMailer
  default from: 'no-replay@gmail.com'

  def registration_mail(team,email)
    @team = team
    @email = email
    @url = "http://localhost:3000/teams/#{@team.id}/add_user"
    mail(subject: "TEAM APPへの登録のご案内" ,to: "#{@email.email}")
  end
end
