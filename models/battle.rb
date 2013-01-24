class Battle
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  has_and_belongs_to_many :masters,     class_name: 'Hero', inverse_of: nil
  has_and_belongs_to_many :challengers, class_name: 'Hero', inverse_of: nil
  has_and_belongs_to_many :winners,     class_name: 'Hero', inverse_of: nil

  embeds_many :turns

  def master;     self.masters.first     end
  def challenger; self.challengers.first end
  def winner;     self.winners.first     end

  def play
    m = master.dup
    c = challenger.dup
    p "#{m.name}(#{m.life}) vs #{c.name}(#{c.life})"

    self.turns.order_by([:counter, :asc]).each do |t|
      if t.afc
        p "#{c.name} attack, #{t.damage} damages"
        m.life = m.life - t.damage
      else
        p "#{m.name} attack, #{t.damage} damages"
        c.life = c.life - t.damage
      end

      p "#{t.counter}: #{m.name}(#{m.life}) - #{c.name}(#{c.life})"

      if m.life <= 0
        p "#{c.name} win!!"
        return
      end
      if c.life <= 0
        p "#{m.name} win!!"
        return
      end
    end
  end
end
