# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'extensions' do
    it { should have_secure_password }
  end

  context 'validations' do
    describe 'first_name' do
      it { should validate_presence_of(:first_name) }
    end

    describe 'last_name' do
      it { should validate_presence_of(:last_name) }
    end

    describe 'email' do
      subject { build(:user) }

      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
    end

    describe 'score' do
      it { should validate_presence_of(:score) }
    end
  end

  context 'instance methods' do
    describe 'full_name' do
      subject { create(:user) }

      it 'should contain first_name' do
        expect(subject.full_name).to include(subject.first_name)
      end

      it 'should contain last_name' do
        expect(subject.full_name).to include(subject.last_name)
      end
    end
  end

  context 'fetch scopes/methods' do
    let!(:leader_user) { FactoryBot.create(:user, score: 4) }
    let!(:second_user) { FactoryBot.create(:user, score: 3) }
    let!(:third_user) { FactoryBot.create(:user, score: 2) }
    let!(:fourth_user) { FactoryBot.create(:user, score: 1) }

    it 'leadboard users' do
      expect(User.leadboard).to eq([leader_user, second_user, third_user,
                                    fourth_user])
    end

    it 'rank user' do
      expect(User.leadboard.map(&:rank)).to eq [1, 2, 3, 4]
    end

    context 'lead' do
      it 'no games' do
        expect(User.lead).to be_nil
      end

      it 'exist games' do
        allow(Game).to receive(:any?) { true }
        expect(User.lead).to eq leader_user
      end
    end
  end
end
