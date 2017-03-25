class AddSecretTokenIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :tournaments, :secret_token, unique: true
  end
end
