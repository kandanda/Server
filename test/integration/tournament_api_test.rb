require 'test_helper'

class TournamentApiTest < ActionDispatch::IntegrationTest
  test "upload tournament results to api" do
    post "/api/v1/tournaments",
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
end
