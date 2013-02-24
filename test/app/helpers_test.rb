require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')
require File.expand_path(Padrino.root + '/app/helpers.rb')

describe UnclejoshHelper do
  let(:helper) { helper = Object.new; helper.extend UnclejoshHelper; }

  describe "fight()" do
    let(:hero1) { Fabricate(:hero, life: 100, strength: 25, agility: 100) }
    let(:hero2) { Fabricate(:hero, life: 100, strength: 10, agility: 1) }

    describe "valid case" do
      subject { helper.fight hero1, hero2 }
      it { subject.master_attacks.count.must_equal 4 }
      it { subject.challenger_attacks.count.must_equal 0 }
      it { subject.master.must_equal hero1 }
      it { subject.challenger.must_equal hero2 }
      it { subject.winner.must_equal hero1 }
    end

    describe "wrong parameter" do
      subject { helper.fight hero1, hero1 }
      it { proc { subject }.must_raise RuntimeError }
    end

    describe "not effect to hero params" do
      before { helper.fight hero1, hero2 }
      specify do
        hero1.life.must_equal 100
        hero2.life.must_equal 100
      end
    end
  end

  describe "rank" do
    let(:hero1) do
      Fabricate(:hero) { ranking_info { |hero| Fabricate(:hero_ranking, :hero => hero, :win_point => 10) } }
    end
    let(:hero2) do
      Fabricate(:hero) { ranking_info { |hero| Fabricate(:hero_ranking, :hero => hero, :win_point => 10) } }
    end
    let(:hero3) do
      Fabricate(:hero) { ranking_info { |hero| Fabricate(:hero_ranking, :hero => hero, :win_point => 20) } }
    end

    specify do
      helper.rank hero1
      Ranking.rank_of(hero1).must_equal 1

      helper.rank hero2
      Ranking.rank_of(hero1).must_equal 1
      Ranking.rank_of(hero2).must_equal 2

      helper.rank hero3
      Ranking.rank_of(hero3).must_equal 1
      Ranking.rank_of(hero1).must_equal 2
      Ranking.rank_of(hero2).must_equal 3
    end
  end

  describe "challenge_rank()" do
    let(:challenger) { Fabricate(:hero) }
    before do
      hero = Fabricate(:hero) do |h|
        h.ranking_info { |hero| Fabricate(:hero_ranking, :hero => hero) }
      end
      helper.rank hero
    end
    subject { helper.challenge_rank challenger }

    specify do
      subject.must_be_nil
      challenger.ranking_info.wont_be_nil
    end
  end

  describe "current_user" do
    let(:user) { Fabricate(:user) }
    subject { helper.current_user user.id }

    specify { subject.must_equal user }
  end
end
