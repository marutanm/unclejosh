require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')
require File.expand_path(Padrino.root + '/app/helpers.rb')

describe "UnclejoshHelper" do
  include UnclejoshHelper

  it 'success' do
    assert_equal 'helper', simple_helper_method
  end
end

