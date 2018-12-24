class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.references :player, foreign_key: { to_table: :users }, index: true,
                            null: false
      t.references :opponent, foreign_key: { to_table: :users }, index: true,
                              null: false
      t.integer :player_score, null: false
      t.integer :opponent_score, null: false
      t.datetime :played_at, null: false

      t.timestamps
    end
  end
end
