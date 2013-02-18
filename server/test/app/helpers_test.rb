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
      Fabricate(:hero) { ranking_info { |hero| Fabricate(:hero_ranking, :hero => hero, :initial_win => 10) } }
    end
    let(:hero2) do
      Fabricate(:hero) { ranking_info { |hero| Fabricate(:hero_ranking, :hero => hero, :initial_win => 10) } }
    end
    let(:hero3) do
      Fabricate(:hero) { ranking_info { |hero| Fabricate(:hero_ranking, :hero => hero, :initial_win => 20) } }
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
    let(:count) { 10 }
    let(:challenger) { Fabricate(:hero) }
    before do
      0.upto(count - 1) do |i|
        hero = Fabricate(:hero) do |h|
          h.name "#{Faker::Name.name} #{i}"
          h.ranking_info { |hero| Fabricate(:hero_ranking, :hero => hero, :initial_win => i) }
        end
        helper.rank hero
      end
    end
    subject { helper.challenge_rank challenger }

    specify do
      count.must_equal 10
      subject.rank.wont_be_nil
      subject.initial_win.wont_be_nil
      subject.rank.must_equal 10 - subject.initial_win + 1
    end
  end

  describe "current_user" do
    let(:user) { Fabricate(:user) }
    subject { helper.current_user user.id }

    specify { subject.must_equal user }
  end
end
