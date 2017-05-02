require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "home page works" do
    get "/"
    assert :success
  end

  test "home page redirects to tournaments when logged in" do
    sign_in Organizer.first!

    get "/"
    assert_redirected_to my_tournaments_path
  end
end
