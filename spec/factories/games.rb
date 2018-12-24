FactoryBot.define do
  factory :game do
    association :player, factory: :user
    association :opponent, factory: :user
    played_at Time.now

    factory :player_win do
      player_score 21
      opponent_score 19
    end

    factory :opponent_win do
      player_score 19
      opponent_score 21
    end
  end
end
