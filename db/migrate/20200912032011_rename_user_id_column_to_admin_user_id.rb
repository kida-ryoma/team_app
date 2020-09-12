class RenameUserIdColumnToAdminUserId < ActiveRecord::Migration[6.0]
  def change
    rename_column :teams, :user_id, :admin_user_id
  end
end
