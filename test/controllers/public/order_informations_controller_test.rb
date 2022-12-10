require "test_helper"

class Public::OrderInformationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_order_informations_new_url
    assert_response :success
  end

  test "should get show" do
    get public_order_informations_show_url
    assert_response :success
  end

  test "should get index" do
    get public_order_informations_index_url
    assert_response :success
  end
end
