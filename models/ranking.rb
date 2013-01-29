class Ranking
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :win_count, :type => Integer
  field :rank,      :type => Integer, :default => 1

  validates_presence_of :win_count, :rank

  def self.challenge(count)
    0.upto count do |c|
      rank = self.find_or_create_by(win_count: c)
      return rank.rank if c == count
      rank.inc(:rank, 1)
    end
  end
end
