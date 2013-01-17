class Turn
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :counter, :type => Integer
  field :damage, :type => Integer
  field :afc, :type => Boolean  # means Attack From Challenger

  embedded_in :battle

end
