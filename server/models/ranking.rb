class Ranking
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :win_count, :type => Integer
  field :rank,      :type => Integer, :default => 1

  validates_presence_of :win_count, :rank
  validates_uniqueness_of :win_count

  has_many :heros

  def self.rank_of(hero)
    ranking = find_by(win_count: hero.ranking_info.win_point)
    return nil unless ranking.heros.index(hero)
    ranking.rank + ranking.heros.index(hero)
  end

  def self.challenge(count)
    0.upto(count - 1) { |c| self.find_or_create_by(win_count: c).inc(:rank, 1) }
    self.find_or_create_by(:win_count => count)
  end
end
