class LeaderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.leader_mailer.new_leader.subject
  #
  def new_leader
    @greeting = "Hi"
    @leader = params[:leader]
    mail(to: @leader.email, subject: 'Congrats you are Ping Pong Master')
  end
end
