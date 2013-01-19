class Hero
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :name, :type => String
  field :life, :type => Integer
  field :strength, :type => Integer
  field :agility, :type => Integer
  field :possibility, :type => Array

  validates_presence_of :name, :life, :strength, :agility

  has_many :battles

  def self.create_with_name(name)
    hex =  Digest::MD5.hexdigest name
    hex_array  = hex.unpack 'A4' * (hex.length / 4)
    life     = (hex_array[0].hex % 1000).succ
    strength = (hex_array[1].hex % 100).succ
    agility  = (hex_array[2].hex % 100).succ
    possibility = hex.split('').inject([]) { |a, i| a << i.hex; a }

    hero = self.create! do |hero|
      hero.name     = name
      hero.life     = life
      hero.strength = strength
      hero.agility  = agility
      hero.possibility = possibility
    end
  end

  def fight(challenger)
    self[:cost] = 100
    challenger[:cost] = 100
    Battle.create!(master: self, challenger: challenger) do |battle|
      1.upto(1000) do |n|
        [self, challenger].each do |hero|
          hero[:cost] = hero[:cost] - hero.agility
          if hero[:cost] < 0
            damage = hero.strength + hero.possibility.sample
            enemy = ([self, challenger] - [hero]).first
            enemy.life = enemy.life - damage
            battle.turns.create!(counter: n, damage: damage, afc: hero == challenger)
            hero[:cost] = hero[:cost].abs
          end
          break if self.life * challenger.life <= 0
        end
      end
    end
  end
end
