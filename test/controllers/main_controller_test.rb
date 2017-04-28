require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
   test "home page works" do
     get "/"
     assert :success

   end
end
