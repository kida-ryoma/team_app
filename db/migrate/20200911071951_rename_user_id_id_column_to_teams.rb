class RenameUserIdIdColumnToTeams < ActiveRecord::Migration[6.0]
  def change
    rename_column :teams, :user_id_id, :user_id
  end
end
