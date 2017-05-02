require 'test_helper'

class TournamentControllerTest < ActionDispatch::IntegrationTest
   test "subscribe without email gives error" do
     tournament = Tournament.find(1)
     assert_equal 1, tournament.tournament_subscriptions.count
     post subscribe_tournament_url(tournament.secret_token)
     assert_redirected_to tournament_path(tournament.secret_token)
     assert_equal 'Email is invalid', flash[:alert]
     assert_nil flash[:notice]
     assert_equal 1, tournament.tournament_subscriptions.count
   end
   test "subscribe works" do
     tournament = Tournament.find(1)
     assert_equal 1, tournament.tournament_subscriptions.count

     post subscribe_tournament_url(tournament.secret_token, email: "somevisitor@kandanda.ch")
     assert_redirected_to tournament_path(tournament.secret_token)
     assert_equal 'Successfully subscribed', flash[:notice]
     assert_nil flash[:alert]
     assert_equal 2, tournament.tournament_subscriptions.count

     get unsubscribe_tournament_url(token: tournament.secret_token, unsubscribe_token: tournament.tournament_subscriptions.first.unsubscribe_token)
     assert_redirected_to tournament_path(tournament.secret_token)
     assert_equal 1, tournament.tournament_subscriptions.count

   end
end
