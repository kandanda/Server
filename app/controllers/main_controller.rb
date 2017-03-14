class MainController < ApplicationController
  def home
  end

  def test_error
    raise "my error"
  end
end
