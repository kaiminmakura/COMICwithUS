require 'test_helper'

class AdminReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admin_reviews_destroy_url
    assert_response :success
  end

end
