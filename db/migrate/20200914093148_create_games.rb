class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.references :team, foreign_key: true
      t.string :opponent
      t.date :date
      t.string :place

      t.timestamps
    end
  end
end
