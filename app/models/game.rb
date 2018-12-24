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

  def score_difference
    (player_score - opponent_score).abs if player_score && opponent_score
  end

  def greater_or_equal_than_min_score?
    player_score && opponent_score &&
      (player_score >= MIN_SCORE || opponent_score >= MIN_SCORE)
  end

  private

  def valid_board
    errors[:base] << 'at least one score must exceed 21 points' unless greater_or_equal_than_min_score?
    errors[:base] << 'difference of points is different than 2' unless score_difference == 2
  end

end
