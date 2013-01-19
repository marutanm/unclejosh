require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Hero Model" do
  it 'can construct a new instance' do
    @hero = Hero.new
    refute_nil @hero
  end

  it 'can construct with name' do
    name = 'hero name'
    @hero = Hero.create_with_name name
    assert_equal 1, Hero.count
    assert_equal name, @hero.name
    assert_includes 0..1000, @hero.life
    assert_includes 0..100, @hero.strength
    assert_includes 0..100, @hero.agility
    assert_kind_of Array, @hero.possibility
  end
end
