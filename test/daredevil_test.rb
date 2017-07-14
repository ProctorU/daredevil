require 'test_helper'

class DaredevilTest < ActiveSupport::TestCase
  test 'Daredevil is actually a thing' do
    assert_kind_of Module, Daredevil
  end

  test 'configuration defaults to jbuilder' do
    assert_equal Daredevil.configuration.default_responder_type, :jbuilder
  end
end
