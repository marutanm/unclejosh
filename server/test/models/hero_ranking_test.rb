require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "HeroRanking Model" do
  it 'can construct a new instance' do
    @hero_ranking = HeroRanking.new
    refute_nil @hero_ranking
  end
end
