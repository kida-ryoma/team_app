class AddTimeToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :time, :time
  end
end
