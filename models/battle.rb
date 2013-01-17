class Battle
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  belongs_to :master, :class_name => 'Hero'
  belongs_to :challenger, :class_name => 'Hero'

  embeds_many :turns

  validates_presence_of :master, :challenger

end
