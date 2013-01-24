require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')
require File.expand_path(Padrino.root + '/app/helpers.rb')

describe UnclejoshHelper, "fight()" do

  let(:helper) { helper = Object.new; helper.extend UnclejoshHelper; }
  let(:hero1) { Fabricate(:hero, life: 100, strength: 25, agility: 100) }
  let(:hero2) { Fabricate(:hero, life: 100, strength: 10, agility: 1) }

  describe "valid case" do
    subject { helper.fight hero1, hero2 }
    it { subject.turns.count.must_equal 4 }
    it { subject.master.must_equal hero1 }
    it { subject.challenger.must_equal hero2 }
    it { subject.winner.must_equal hero1 }
  end

  describe "wrong parameter" do
    subject { helper.fight hero1, hero1 }
    it { proc { subject }.must_raise RuntimeError }
  end
end

