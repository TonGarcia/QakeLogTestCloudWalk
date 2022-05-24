class CreateKills < ActiveRecord::Migration[6.1]
  def change
    create_table :kills do |t|
      t.integer :cause, null: false
      t.belongs_to :player, null: false, foreign_key: true
      t.belongs_to :game, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
