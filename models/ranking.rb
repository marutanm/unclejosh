class Ranking
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :win_count, :type => Integer
  field :rank,      :type => Integer, :default => 1

  validates_presence_of :win_count, :rank
  validates_uniqueness_of :win_count

  def self.challenge(count)
    0.upto(count - 1) { |c| self.find_or_create_by(win_count: c).inc(:rank, 1) }
    self.find_or_create_by(:win_count => count)
  end
end
