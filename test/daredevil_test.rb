require 'test_helper'

class DaredevilTest < ActionDispatch::IntegrationTest
  setup do
    @params = { params: { format: :json } }
  end

  test 'Daredevil is actually a thing' do
    assert_kind_of Module, Daredevil
  end

  test 'configuration defaults to jbuilder' do
    assert_equal Daredevil.configuration.default_responder_type, :jbuilder
  end

  test 'it has a gem version' do
    assert_not_nil Daredevil::VERSION
  end

  test 'normal success response' do
    get posts_url, @params
    assert_response :success
  end
end
