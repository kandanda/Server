class Api::V1::TournamentsController < Api::V1::ApiController
  def create
    #TODO check this against organizer
    organizer = Organizer.last
    unless (id = params[:tournament].delete(:id)) && @touranment = organizer.tournaments.where(id: id).first
      @tournament = organizer.tournaments.build
    end
    par = params.require(:tournament)
    Tournament.transaction do 
      @tournament.name= par['name']
      if @tournament.save
        @tournament.phases.destroy_all
        par[:phases].each do |phase_par|
          phase = @tournament.phases.create!(phase_par.slice(:name, :from, :until).permit!)
          phase_par[:matches]&.each do |match_par|
            match = phase.matches.create!(match_par.slice(:from, :until, :place).permit!)
            match_par[:participants]&.each do |participant|
              match.participants.create participant.slice(:name, :result).permit!
            end
          end
        end
        render json: { tournament: {id: @tournament.id}}
      else
        render json: @tournament.errors, status: :unprocessable_entity 
      end
    end
  end

end
