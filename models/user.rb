class User
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :name, :type => String
  validates_uniqueness_of :name, message: 'user name duplicated'

  has_many :heros

  def name
    self[:name] or 'NONAME'
  end
end
