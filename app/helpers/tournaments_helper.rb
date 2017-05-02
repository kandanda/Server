module TournamentsHelper
  def filter_link(participant)
    if participant
      link_to participant.name, tournament_path(@tournament.secret_token, participant_filter: participant.name)
    end
  end
end
