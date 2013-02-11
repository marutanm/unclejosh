class User
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :name, :type => String

  validates :name, uniqueness: true

  def name
    self[:name] or 'NONAME'
  end
end
