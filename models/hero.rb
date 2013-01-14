class Hero
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :name, :type => String
  field :life, :type => Integer

  validates_presence_of :name

  def self.named(name)
    hex =  Digest::MD5.hexdigest name
    hex_array  = hex.unpack 'A4' * (hex.length / 4)
    life = (hex_array[0].hex % 1000).succ
    hero = self.new name: name, life: life
    hero
  end
end
