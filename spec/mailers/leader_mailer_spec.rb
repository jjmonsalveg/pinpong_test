require "rails_helper"

RSpec.describe LeaderMailer, type: :mailer do
  describe "new_leader" do
    let(:user) { FactoryBot.create(:user)}
    let(:mail) { LeaderMailer.with(leader: user).new_leader }

    it "renders the headers" do
      expect(mail.subject).to eq('Congrats you are Ping Pong Master')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("#{user.first_name}, you are the new leader, Congratulations!")
    end
  end

end
