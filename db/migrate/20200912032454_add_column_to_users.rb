class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :team, optional: true
  end
end
