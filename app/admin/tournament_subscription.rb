ActiveAdmin.register TournamentSubscription do
  index do
    actions
    column :email
    column :tournament do |r|
      link_to r.tournament.name, tournament_path(id: r.tournament.secret_token)
    end
    column :unsubscribe_token
    column :created_at

  end
end
