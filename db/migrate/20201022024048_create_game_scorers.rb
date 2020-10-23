class CreateGameScorers < ActiveRecord::Migration[6.0]
  def change
    create_table :game_scorers do |t|
      t.references :game_result, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
