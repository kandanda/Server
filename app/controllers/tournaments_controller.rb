class TournamentsController < ApplicationController
  def show
    @tournament = Tournament.where(secret_token: params[:id]).first!
  end
  def my
    @tournaments = current_organizer.tournaments
  end
end
