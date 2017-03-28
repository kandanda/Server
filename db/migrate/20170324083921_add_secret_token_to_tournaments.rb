class AddSecretTokenToTournaments < ActiveRecord::Migration[5.0]
  def change
    add_column :tournaments, :secret_token, :string
    Tournament.all.each &:set_token
    change_column :tournaments, :secret_token, :string
  end
end
