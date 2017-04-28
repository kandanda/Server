class TournamentMailer < ApplicationMailer
  default from: "no-reply@kandanda.ch"
  layout 'mailer'

  def update_email(tournament, email, unsubscribe_token)
    @tournament = tournament
    @unsubscribe_token = unsubscribe_token
    mail(to: email, subject: "[Kandanda] Tournament #{tournament.name} updated")
  end
end
