class Hero
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :name, :type => String
  field :life, :type => Integer
  field :strength, :type => Integer
  field :agility, :type => Integer

  validates_presence_of :name, :life, :strength, :agility

  def self.named(name)
    hex =  Digest::MD5.hexdigest name
    hex_array  = hex.unpack 'A4' * (hex.length / 4)
    life     = (hex_array[0].hex % 1000).succ
    strength = (hex_array[1].hex % 100).succ
    agility  = (hex_array[2].hex % 100).succ

    hero = self.new do |hero|
      hero.name     = name
      hero.life     = life
      hero.strength = strength
      hero.agility  = agility
    end
  end
end
