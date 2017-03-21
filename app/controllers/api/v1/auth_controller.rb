class Api::V1::AuthController < ApplicationController
  def create
    organizer = params[:email]
    password = params[:password]

    organizer = Organizer.find_for_database_authentication(email: params[:email])
    if organizer.valid_password?(params[:password])
      render json: payload(organizer)
    else
      render json: {errors: ['Invalid Email/Password']}, status: :unauthorized
    end
  end

  private

  def payload(organizer)
    return nil unless organizer and organizer.id
    {
      auth_token: encode({organizer_id: organizer.id}),
      organizer: {id: organizer.id, email: organizer.email}
    }
  end


  def encode(payload, expiration = nil)
    expiration ||= Rails.application.secrets.jwt_expiration_hours

    payload = payload.dup
    payload['exp'] = expiration.to_i.hours.from_now.to_i

    JWT.encode payload, Rails.application.secrets.jwt_secret
  end
end
