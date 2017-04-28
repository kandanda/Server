require 'test_helper'

class TournamentMailerTest < ActionMailer::TestCase
  test "update" do
    # Create the email and store it for further assertions
    email = TournamentMailer.update_email(Tournament.first, 'subscriber@kandanda.ch', '1234123412341234')
 
    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end
 
    # Test the body of the sent email contains what we expect it to
    assert_equal ['no-reply@kandanda.ch'], email.from
    assert_equal ['subscriber@kandanda.ch'], email.to
    assert_equal '[Kandanda] Tournament Tournier März updated', email.subject
  end
end
