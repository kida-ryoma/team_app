class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.references :team, foreign_key: true
      t.string :opponent
      t.datetime :date
      t.datetime :begin_time
      t.datetime :finish_time
      t.string :place

      t.timestamps
    end
  end
end
