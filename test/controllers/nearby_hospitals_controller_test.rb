require "test_helper"

class NearbyHospitalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nearby_hospitals_index_url
    assert_response :success
  end

  test "should get search" do
    get nearby_hospitals_search_url
    assert_response :success
  end
end
