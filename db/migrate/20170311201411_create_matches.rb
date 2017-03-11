class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.integer :phase_id, null: false
      t.datetime :from, null: false
      t.datetime :until, null: false
      t.string :place, null: false

      t.timestamps
    end
  end
end
