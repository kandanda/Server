require 'test_helper'

class TournamentControllerTest < ActionDispatch::IntegrationTest
   test "subscribe works" do
     tournament = Tournament.find(1)
     post subscribe_tournament_url(tournament.secret_token)
     assert_redirected_to tournament_path(tournament.secret_token)
     assert_equal tournament.tournament_subscriptions.count, 1
     get unsubscribe_tournament_url(token: tournament.secret_token, unsubscribe_token: tournament.tournament_subscriptions.first.unsubscribe_token)
     assert_redirected_to tournament_path(tournament.secret_token)
     assert_equal tournament.tournament_subscriptions.count, 0

   end
end
