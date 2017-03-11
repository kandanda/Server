class TournamentsController < ApplicationController
  def show
    @tournament = Tournament.find(params[:id])
  end
  def my
    @tournaments = current_organizer.tournaments
  end
end
