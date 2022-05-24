class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :total_kills, null: false
      t.datetime :deleted_at, null: true

      t.timestamps
    end
  end
end
