require 'test_helper'

class TournamentApiTest < ActionDispatch::IntegrationTest
  def setup
    @organizer = Organizer.first

  end

  def login
    post "/api/v1/auth",
      params: {email: 'test@kandanda.ch', password: 'secret' }

    @token = JSON.parse(response.body)['auth_token']
  end

  test "tournament upload with tempered token is rejected" do
    login
    tempered_token = temper_with(@token)
    post "/api/v1/tournaments",
      headers: {"Authorization" =>  "Bearer #{tempered_token}"},
      params: JSON.parse(File.read(File.join(Rails.root, "test/example_requests/push_tournament_1.json")))
    assert_redirected_to new_organizer_session_path
  end

  test "tournament upload with invalid params fails gracefully" do
    login
    post "/api/v1/tournaments",
      headers: {"Authorization" =>  "Bearer #{@token}"},
      params: {}
    assert_response :unprocessable_entity
    assert_equal response.body, "param is missing or the value is empty: tournament"

    post "/api/v1/tournaments",
      headers: {"Authorization" =>  "Bearer #{@token}"},
      params: { tournament: {}}

    post "/api/v1/tournaments",
      headers: {"Authorization" =>  "Bearer #{@token}"},
      params: { tournament: {name: ''}}
    assert_response :unprocessable_entity

    post "/api/v1/tournaments",
      headers: {"Authorization" =>  "Bearer #{@token}"},
      params: { tournament: {name: 'my tourney', phases: [{from: Time.now}]}}
    assert_response :unprocessable_entity

    post "/api/v1/tournaments",
      headers: {"Authorization" =>  "Bearer #{@token}"},
      params: { tournament: {name: 'my tourney', phases: [{from: Time.now, until: 10.minutes.from_now}]}}
    assert_response :unprocessable_entity
    assert_includes JSON.parse(response.body)['phase']['name'], "can't be blank"

    post "/api/v1/tournaments",
      headers: {"Authorization" =>  "Bearer #{@token}"},
      params: { tournament: {name: 'my tourney', phases: [{name: "myphase", from: Time.now, until: 10.minutes.ago}]}}
    assert_response :unprocessable_entity
    assert_includes JSON.parse(response.body)['phase']['until'], "must be after from"
  end


  test "upload tournament results to api" do
    login
    post "/api/v1/tournaments",
      headers: {"Authorization" =>  "Bearer #{@token}"},
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
