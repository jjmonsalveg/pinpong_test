require 'rails_helper'

RSpec.describe Game, type: :model do

  describe 'valid game' do
    context 'validates' do
      it { should validate_presence_of(:player) }
      it { should validate_presence_of(:opponent) }
      it { should validate_presence_of(:player_score) }
      it { should validate_presence_of(:opponent_score) }
      it { should validate_presence_of(:played_at) }
    end

    context 'valid board' do
      let(:game) { FactoryBot.build(:player_win) }
      it 'at least one score is greater than 21 and score difference is 2' do
        expect(game.save).to be_truthy
      end
    end
  end

  describe 'invalid game' do
    context 'invalid board' do
      it 'no score exceeds 21 points' do
        game = FactoryBot.build(:game, player_score: 17, opponent_score: 16)
        game.valid?
        expect(game.errors[:base]).to include('at least one score must exceed 21 points')
      end

      it 'difference of points is different than 2' do
        game = FactoryBot.build(:game, player_score: 24, opponent_score: 21)
        game.valid?
        expect(game.errors[:base]).to include ('difference of points is different than 2')
      end
    end
  end
end
