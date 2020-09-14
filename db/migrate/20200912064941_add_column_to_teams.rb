class AddColumnToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :image, :string
  end
end
