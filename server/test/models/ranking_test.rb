require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Ranking Model" do
  it 'can construct a new instance' do
    @ranking = Ranking.new
    refute_nil @ranking
  end

  describe 'rank_of()' do
    let(:hero1) do
      Fabricate(:hero) { ranking_info { |hero| Fabricate(:hero_ranking, :hero => hero, :win_point => 10) } }
    end
    let(:hero2) do
      Fabricate(:hero) { ranking_info { |hero| Fabricate(:hero_ranking, :hero => hero, :win_point => 10) } }
    end
    let(:ranking) { Fabricate(:ranking, win_count: 10, rank: 15) }

    specify do
      ranking.heros << hero1
      Ranking.rank_of(hero1).must_equal 15
      Ranking.rank_of(hero2).must_equal nil

      ranking.heros << hero2
      Ranking.rank_of(hero1).must_equal 15
      Ranking.rank_of(hero2).must_equal 16
    end
  end

  describe 'challenge()' do
    it 'find or create document and increment rank' do
      Ranking.challenge(10).rank.must_equal 1
      0.upto(9) do |i|
        Ranking.find_by(win_count: i).rank.must_equal 2
      end
      Ranking.count.must_equal 11

      Ranking.challenge(30).rank.must_equal 1
      10.upto(29) do |i|
        Ranking.find_by(win_count: i).rank.must_equal 2
      end
      0.upto(9) do |i|
        Ranking.find_by(win_count: i).rank.must_equal 3
      end
      Ranking.count.must_equal 31

      Ranking.challenge(20).rank.must_equal 2
      Ranking.find_by(win_count: 30).rank.must_equal 1
      20.upto(29) do |i|
        Ranking.find_by(win_count: i).rank.must_equal 2
      end
      10.upto(19) do |i|
        Ranking.find_by(win_count: i).rank.must_equal 3
      end
      0.upto(9) do |i|
        Ranking.find_by(win_count: i).rank.must_equal 4
      end
      Ranking.count.must_equal 31
    end
  end
end

