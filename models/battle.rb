class Battle
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :_id, type: String, default: -> { default_id }

  has_and_belongs_to_many :masters,     class_name: 'Hero', inverse_of: nil
  has_and_belongs_to_many :challengers, class_name: 'Hero', inverse_of: nil
  has_and_belongs_to_many :winners,     class_name: 'Hero', inverse_of: nil

  embeds_many :master_attacks,      class_name: 'Turn'
  embeds_many :challenger_attacks,  class_name: 'Turn'

  validates_presence_of :masters, :challengers
  validates_uniqueness_of :_id

  def master;     self.masters.first     end
  def challenger; self.challengers.first end
  def winner;     self.winners.first     end

  validate :masters_count, :challengers_count

  def turns
    turns = [] << master_attacks.clone.each {|t| t['owner'] = 'master' }
    turns << challenger_attacks.clone.each {|t| t['owner'] = 'challenger' }
    turns.flatten!.sort! do |a, b|
      (a.counter <=> b.counter).nonzero? or (b.owner <=> a.owner)
    end
  end

  private

  def default_id
    master_id = master.id rescue 'master_id'
    challenger_id = challenger.id rescue 'challenger_id'
    "#{master_id}:#{challenger_id}"
  end

  def masters_count
    errors.add :masters, 'count must equal 1' unless masters.count == 1
  end
  def challengers_count
    errors.add :challengers, 'count must equal 1' unless challengers.count == 1
  end

end
