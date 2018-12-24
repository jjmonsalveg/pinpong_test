# frozen_string_literal: true
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

class GameSerializer < ActiveModel::Serializer
  attributes :id, :player_id, :player_score, :opponent_id, :opponent_score, :played_at
end
