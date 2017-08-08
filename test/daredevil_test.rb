require 'test_helper'

class DaredevilTest < ActionDispatch::IntegrationTest
  test 'Daredevil is actually a thing' do
    assert_kind_of Module, Daredevil
  end

  test 'configuration defaults to jbuilder' do
    assert_equal Daredevil.configuration.responder_type, :jbuilder
  end

  test 'it has a gem version' do
    assert_not_nil Daredevil::VERSION
  end
end
