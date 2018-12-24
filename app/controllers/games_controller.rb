class GamesController < ApplicationController
  before_action :find_game, only: :show

  def index
    @games = Game.paginate(page: params[:page],
                           per_page: params[:per_page]).order(played_at: :desc)
    render json: @games, each_serializer: GameSerializer
  end

  def show
    render json: GameSerializer.new(@game)
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      render json: GameSerializer.new(@game), status: :created
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:game).permit(:player_id, :player_score, :opponent_id, :opponent_score, :played_at)
  end

  def find_game
    @game ||= Game.find_by(id: params[:id])
    head :not_found unless @game
  end
end
