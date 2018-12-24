# == Schema Information
#
# Table name: games
#
#  id             :integer          not null, primary key
#  player_id      :integer          not null
#  opponent_id    :integer          not null
#  player_score   :integer          not null
#  opponent_score :integer          not null
#  played_at      :datetime         not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_games_on_opponent_id  (opponent_id)
#  index_games_on_player_id    (player_id)
#

class Game < ApplicationRecord
  MIN_SCORE = 21
  belongs_to :player, class_name: 'User'
  belongs_to :opponent, class_name: 'User'

  validates :player, presence: true
  validates :opponent, presence: true
  validates :player_score, presence: true
  validates :opponent_score, presence: true
  validates :played_at, presence: true
  validate :valid_board
  validate :gamers

  after_create :update_rank

  def score_difference
    (player_score - opponent_score).abs if scores?
  end

  def any_finish_score?
    scores? && (player_score >= MIN_SCORE || opponent_score >= MIN_SCORE)
  end

  def extend?
    scores? && player_score >= MIN_SCORE && opponent_score >= MIN_SCORE
  end

  def winner
    @winner ||= player_score > opponent_score ? player : opponent
  end

  def loser
    @loser ||= winner == player ? opponent : player
  end

  private

  def gamers
    errors[:base] << 'game need 2 gamers'  if player == opponent
  end

  def scores?
    player_score && opponent_score
  end

  def valid_board
    errors[:base] << 'at least one score must exceed 21 points' unless any_finish_score?
    errors[:base] << 'extend game difference of points is less than than 2' if invalid_extend_game?
  end

  def invalid_extend_game?
    extend? && score_difference != 2
  end

  def update_rank
    leader = User.lead
    winner.update(score: winner.score + 1 + weight_game)
    new_lead = User.lead
    LeaderMailer.with(leader: new_lead).new_leader.deliver_later if new_lead != leader
  end

  def weight_game
    winner.score > loser.score ? 0 : (winner.rank - loser.rank).to_f / User.count
  end

end
