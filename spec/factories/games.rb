FactoryBot.define do
  factory :game do
    association :player, factory: :user, strategy: :build
    association :opponent, factory: :user, strategy: :build
    played_at Time.now
    player_score 21
    opponent_score 9

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
