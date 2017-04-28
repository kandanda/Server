require 'test_helper'

class AdminTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers
  def setup
    @admin = AdminUser.first
    Warden.test_mode!
    login_as @admin
  end
  teardown do
    Warden.test_reset!
  end

  test "test show of dashboard" do
    get "/admin"
    assert_response :success
  end

  test "test show of admin users" do
    get "/admin/admin_users"
    assert_response :success
  end

  test "test show of organizers" do
    get "/admin/organizers"
    assert_response :success
  end
end


