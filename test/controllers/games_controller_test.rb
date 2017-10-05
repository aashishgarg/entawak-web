require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get introduction" do
    get games_introduction_url
    assert_response :success
  end

end
