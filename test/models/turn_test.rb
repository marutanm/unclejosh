require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Turn Model" do
  it 'can construct a new instance' do
    @turn = Turn.new
    refute_nil @turn
  end
end
