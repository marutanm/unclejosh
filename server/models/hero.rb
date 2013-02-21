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

  belongs_to :user

  belongs_to :ranking

  embeds_one :ranking_info, class_name: 'HeroRanking', inverse_of: :hero

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
end
