class HeroRanking
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :initial_win, :type => Integer
  field :total_win, :type => Integer

  embedded_in :hero, inverse_of: :ranking
end
