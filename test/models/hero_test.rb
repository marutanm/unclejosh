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

  describe "fight" do
    let(:hero1) { Fabricate(:hero, life: 100, strength: 25, agility: 100) }
    let(:hero2) { Fabricate(:hero, life: 100, strength: 10, agility: 1) }
    before { hero1.fight hero2 }

    it 'finishes 4 turns' do
      assert_equal 4, Battle.first.turns.count
    end
  end
end
