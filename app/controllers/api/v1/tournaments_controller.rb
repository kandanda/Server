class Api::V1::TournamentsController < Api::V1::ApiController
  before_filter :authenticate_organizer!
  def create
    organizer = current_organizer
    begin
      par = params.require(:tournament) 
      unless (id = params[:tournament].delete(:id)) && @tournament = organizer.tournaments.where(id: id).first
        @tournament = organizer.tournaments.build
      end
      Tournament.transaction do 
        @tournament.name= par['name']
        if @tournament.save
          @tournament.phases.destroy_all
          par.require(:phases)
          par[:phases].each do |phase_par|
            phase_par.require([:name, :from, :until])
            phase = @tournament.phases.create!(phase_par.slice(:name, :from, :until).permit!)
            phase_par[:matches]&.each do |match_par|
              match_par.require([:from, :until, :place])
              match = phase.matches.create!(match_par.slice(:from, :until, :place).permit!)
              match_par[:participants]&.each do |participant|
                participant.require(:name)
                match.participants.create participant.slice(:name, :result).permit!
              end
            end
          end
          render json: { tournament: {id: @tournament.id}}
        else
          render json: @tournament.errors, status: :unprocessable_entity 
        end
      end
    rescue ActionController::ParameterMissing => e
      render json: e, status: :unprocessable_entity 
    end
  end

end
