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

    context 'finish with valid board' do
      let(:normal_game) { FactoryBot.build(:player_win) }
      let(:extend_game) { FactoryBot.build(:game, player_score: 31, opponent_score: 29) }
      it 'normal game' do
        expect(normal_game.save).to be_truthy
      end

      it 'finish extend game' do
        expect(extend_game.save).to be_truthy
      end
    end
  end

  describe 'No finish game' do
    it 'Scores less than 21' do
      game = FactoryBot.build(:game, player_score: 17, opponent_score: 16)
      game.valid?
      expect(game.errors[:base]).to include('at least one score must exceed 21 points')
    end

    it 'Extend game with difference of points is less than 2' do
      game = FactoryBot.build(:game, player_score: 24, opponent_score: 21)
      game.valid?
      expect(game.errors[:base]).to include ('extend game difference of points is less than than 2')
    end
  end
end
