# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe 'GET #index' do
    let!(:player) { create(:user) }
    let!(:opponent) { create(:user) }
    let!(:first_game) { create(:game, player: player, opponent: opponent) }
    let!(:second_game) { create(:game, player: player, opponent: opponent) }
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)
               .map { |game| game['id'] }).to eq([first_game.id, second_game.id])
      expect(response.content_type).to eq('application/json')
    end
  end

  describe 'GET #show' do
    context 'exist resource' do
      let(:game) { FactoryBot.create(:player_win) }

      it 'returns http success' do
        get :show, params: { id: game.id }
        expect(response).to be_successful
        expect(response.content_type).to eq('application/json')
      end

      it 'assings requested game to  @game' do
        get :show, params: { id: game.id }
        expect(assigns(:game)).to eq(game)
      end
    end

    context 'Resource not found' do
      it 'returns http not_found' do
        get :show, params: { id: 1 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    let(:player) { create(:user) }
    let(:opponent) { create(:user) }
    let(:params) do
      { game: FactoryBot.attributes_for(:game).merge(player_id: player.id,
                                                     opponent_id: opponent.id) }
    end

    context 'correct data' do
      it ' returns http created' do
        post :create, params: params
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end

      it 'create new game in database' do
        expect { post :create, params: params }.to change(Game, :count).by(1)
      end
    end

    context 'incorrect data' do
      it ' returns http unprocessable_entity' do
        post :create, params: { game: FactoryBot.attributes_for(:game) }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end

      it 'create new game in database' do
        expect {
          post :create, params: { game: FactoryBot.attributes_for(:game) }
        }.not_to change(Game, :count)
      end
    end
  end
end
