class CreateKills < ActiveRecord::Migration[6.1]
  def change
    create_table :kills do |t|
      t.integer :cause, null: false
      t.integer :killer_id, null: false, foreign_key: true
      t.integer :killed_id, null: false, foreign_key: true
      t.belongs_to :game, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end

    add_reference :kills, :killer_id, foreign_key: { to_table: :players }
    add_reference :kills, :killed_id, foreign_key: { to_table: :players }
  end
end
