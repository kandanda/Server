class CreateTournamentSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :tournament_subscriptions do |t|
      t.integer :tournament_id, null: false
      t.string :email, null: false
      t.string :unsubscribe_token, null: false

      t.timestamps
    end
  end
end
