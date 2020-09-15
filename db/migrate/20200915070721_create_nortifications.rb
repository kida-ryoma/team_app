class CreateNortifications < ActiveRecord::Migration[6.0]
  def change
    create_table :nortifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :game_id, null: false
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
