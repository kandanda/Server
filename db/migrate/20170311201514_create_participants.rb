class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.string :name, null: false
      t.integer :result
      t.integer :match_id, null: false

      t.timestamps
    end
  end
end
