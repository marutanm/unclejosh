class Battle
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  belongs_to :master, :class_name => 'Hero'
  belongs_to :challenger, :class_name => 'Hero'
  has_one :winner, :class_name => 'Hero'

  embeds_many :turns

  validates_presence_of :master, :challenger

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
