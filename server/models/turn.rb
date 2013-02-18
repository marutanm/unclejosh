class Turn
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :counter, :type => Integer
  field :damage, :type => Integer

  embedded_in :battle

end
