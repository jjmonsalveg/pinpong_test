# Preview all emails at http://localhost:3000/rails/mailers/leader_mailer
class LeaderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/leader_mailer/new_leader
  def new_leader
    LeaderMailer.with(leader: User.lead).new_leader
  end

end
