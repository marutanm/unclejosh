class Battle
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  has_and_belongs_to_many :masters,     class_name: 'Hero', inverse_of: nil
  has_and_belongs_to_many :challengers, class_name: 'Hero', inverse_of: nil
  has_and_belongs_to_many :winners,     class_name: 'Hero', inverse_of: nil

  embeds_many :turns

  validates_presence_of :masters, :challengers

  def master;     self.masters.first     end
  def challenger; self.challengers.first end
  def winner;     self.winners.first     end

  validate :masters_count, :challengers_count
  before_save :unique_hero

  def masters_count
    errors.add :masters, 'count must equal 1' unless masters.count == 1
  end
  def challengers_count
    errors.add :challengers, 'count moust equal 1' unless challengers.count == 1
  end

  def unique_hero
    raise if self.class.where(:master_ids => [ masters.first.id ]).where(:challenger_ids => [ challengers.first.id ]).exists?
  end

end
