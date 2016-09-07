require 'test_helper'

class HighVoltage::TestPagesController < ActionDispatch::IntegrationTest
  test 'GET home' do
    get '/'
    assert_response :success
    assert_template :home
  end
end
