class CreatePhases < ActiveRecord::Migration[5.0]
  def change
    create_table :phases do |t|
      t.string :name, null: false
      t.datetime :from, null: false
      t.datetime :until, null: false
      t.integer :tournament_id, null: false

      t.timestamps
    end
  end
end
