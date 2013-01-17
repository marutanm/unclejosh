require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Battle Model" do
  it 'can construct a new instance' do
    @battle = Battle.new
    refute_nil @battle
  end
end
