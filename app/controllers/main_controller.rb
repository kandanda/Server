class MainController < ApplicationController
  def home
    if current_organizer
      redirect_to my_tournaments_path
    else
      render
    end
  end

end
