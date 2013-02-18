require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Hero Model" do
  it 'can construct a new instance' do
    @hero = Hero.new
    refute_nil @hero
  end

  describe 'create_with_name()' do
    let (:name) { 'hero name' }
    subject { Hero.create_with_name name }

    it { subject.name.must_equal name }
    it { assert_includes 0..1000, subject.life }
    it { assert_includes 0..100, subject.strength }
    it { assert_includes 0..100, subject.agility }
    it { assert_kind_of Array, subject.possibility }
  end
end
