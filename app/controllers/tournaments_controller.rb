class TournamentsController < ApplicationController
  before_action :authenticate_organizer!, only: [:my]
  def show
    @tournament = Tournament.where(secret_token: params[:id]).first!
    @participant_filter = params[:participant_filter]
  end
  def my
    @tournaments = current_organizer.tournaments
  end
  def subscribe
    @tournament = Tournament.where(secret_token: params[:id]).first!
    @tournament_subscription = TournamentSubscription.new
    @tournament_subscription.tournament = @tournament
    @tournament_subscription.email = params[:email]
    if @tournament_subscription.save
      redirect_to tournament_path(id: @tournament.secret_token), flash: {notice: "Sucessfully subscribed"}
    else
      @tournament_subscription.errors.full_messages.each do |e|
        flash[:alert]= e
      end
      redirect_to tournament_path(id: @tournament.secret_token)
    end
  end
  def unsubscribe
    @tournament = Tournament.where(secret_token: params[:token]).first!
    @tournament_subscription = @tournament.tournament_subscriptions.where(unsubscribe_token: params[:unsubscribe_token]).first!
    @tournament_subscription.destroy
    redirect_to tournament_path(id: @tournament.secret_token), flash: {notice: "Sucessfully unsubscribed"}
  end
end
