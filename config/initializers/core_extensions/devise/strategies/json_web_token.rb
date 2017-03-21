module Devise
	module Strategies
		class JsonWebToken < Base
			def valid?
				request.headers['Authorization'].present?
			end

			def authenticate!
				return fail! unless claims
				return fail! unless claims.has_key?('organizer_id')

				success! Organizer.find_by_id claims['organizer_id']
			end

			protected ######################## PROTECTED #############################

			def claims
				strategy, token = request.headers['Authorization'].split(' ')

				return nil if (strategy || '').downcase != 'bearer'

				decode(token) rescue nil
			end
			def decode(token)
				begin
					decoded_token = JWT.decode token, Rails.application.secrets.jwt_secret

					decoded_token.first
				rescue
					nil
				end
			end
		end
	end
end
