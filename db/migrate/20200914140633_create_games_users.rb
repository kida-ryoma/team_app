class CreateGamesUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :games_users do |t|
      t.references :game, type: :bigint, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :status, default: 1, null: false, foreign_key: true

      t.timestamps
    end
  end
end
