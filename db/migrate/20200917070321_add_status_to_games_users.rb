class AddStatusToGamesUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :games_users, :status, :string, default: 'notyet', null: false
  end
end
