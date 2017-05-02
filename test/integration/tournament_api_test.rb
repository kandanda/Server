require 'test_helper'

class TournamentApiTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper
  def setup
    @organizer = Organizer.first

  end

  def login
    post "/api/v1/auth",
      params: {email: 'test@kandanda.ch', password: 'secret' }

    @token = JSON.parse(response.body)['auth_token']
  end

  test "test invalid login on api auth" do
    post "/api/v1/auth",
      params: {email: 'invalid@kandanda.ch', password: 'secret' }

    assert_includes JSON.parse(response.body)['errors'], "Invalid Email/Password"
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
    assert_equal JSON.parse(response.body)['error'], "param is missing or the value is empty: tournament"

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
    assert_includes JSON.parse(response.body)['error']['phase']['name'], "can't be blank"

    post "/api/v1/tournaments",
      headers: {"Authorization" =>  "Bearer #{@token}"},
      params: { tournament: {name: 'my tourney', phases: [{name: "myphase", from: Time.now, until: 10.minutes.ago}]}}
    assert_response :unprocessable_entity
    assert_includes JSON.parse(response.body)['error']['phase']['until'], "must be after from"

    post "/api/v1/tournaments",
      headers: {"Authorization" =>  "Bearer #{@token}"},
      params: { tournament: {name: 'my tourney', phases: [{
        name: "myphase", from: Time.now, until: 10.minutes.from_now, matches: [{
          from: Time.now, until: 5.minutes.ago, place: "Hall 1"
        }]
      }]}}
    assert_response :unprocessable_entity
    assert_includes JSON.parse(response.body)['error']['match']['until'], "must be after from"

  end


  test "upload tournament results to api" do
    login
    post "/api/v1/tournaments",
      headers: {"Authorization" =>  "Bearer #{@token}"},
      params: JSON.parse(File.read(File.join(Rails.root, "test/example_requests/push_tournament_1.json")))

    assert_response :success

    t = Tournament.last
    assert_equal "My little tournament", t.name
    assert_includes t.location, "HSR"
    assert_equal 2, t.phases.count
    assert_equal 2, t.phases.first.matches.count
    assert_equal 2, t.phases.first.matches.first.participants.count
    assert_equal "Team 1", t.phases.first.matches.first.participants.first.to_s
    assert_equal 2, t.phases.first.matches.last.participants.count
    assert_equal 0, t.phases.last.matches.count

    link = JSON.parse(response.body)['tournament']['link']
    assert_equal link, "/tournaments/#{Tournament.last.secret_token}"

    get link

    assert_response :success

    get '/tournaments/my'

    assert_response :success
    assert_includes response.body, "My little tournament"

    t.tournament_subscriptions.create!(email: "subscriber@kandanda.ch")
    perform_enqueued_jobs do
      post "/api/v1/tournaments",
        headers: {"Authorization" =>  "Bearer #{@token}"},
        params: JSON.parse(File.read(File.join(Rails.root, "test/example_requests/push_tournament_2.json")).gsub("1234", t.id.to_s))
    end

    assert_response :success

    assert_equal t.id, Tournament.last.id
    t.reload
    assert_equal "My little updated tournament", t.name
    assert_includes "Gruppenphase 1", t.phases.first.name
    email = ActionMailer::Base.deliveries.last
    assert_equal ['no-reply@kandanda.ch'], email.from
    assert_equal ['subscriber@kandanda.ch'], email.to
    assert_equal '[Kandanda] Tournament Tournier März updated', email.subject
  end

  def temper_with(token)
    # TODO attempt more realistic attack
    token = token.dup
    token[15] = "J"
  end

end
