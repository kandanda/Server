require 'test_helper'

class TournamentApiTest < ActionDispatch::IntegrationTest
  test "upload tournament results to api" do
    @organizer = Organizer.first

    post "/api/v1/auth",
      params: {email: 'test@kandanda.ch', password: 'secret' }

    token = JSON.parse(response.body)['auth_token']

    tempered_token = temper_with(token)
    post "/api/v1/tournaments",
      headers: {"Authorization" =>  "Bearer #{tempered_token}"},
      params: JSON.parse(File.read(File.join(Rails.root, "test/example_requests/push_tournament_1.json")))

    assert_redirected_to new_organizer_session_path

    post "/api/v1/tournaments",
      headers: {"Authorization" =>  "Bearer #{token}"},
      params: JSON.parse(File.read(File.join(Rails.root, "test/example_requests/push_tournament_1.json")))

    assert_response :success
    t = Tournament.last
    assert_equal "My little tournament", t.name
    assert_equal 2, t.phases.count
    assert_equal 2, t.phases.first.matches.count
    assert_equal 2, t.phases.first.matches.first.participants.count
    assert_equal 2, t.phases.first.matches.last.participants.count
    assert_equal 0, t.phases.last.matches.count
  end

  def temper_with(token)
    # TODO attempt more realistic attack
    token = token.dup
    token[15] = "J"
  end

end
