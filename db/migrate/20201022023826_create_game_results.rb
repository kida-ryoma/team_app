class CreateGameResults < ActiveRecord::Migration[6.0]
  def change
    create_table :game_results do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :my_score
      t.integer :rival_score

      t.timestamps
    end
  end
end
