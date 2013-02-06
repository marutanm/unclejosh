object @battle
attributes :id

node :master do
  partial("hero", :object => @battle.master)
end

node :challenger do
  partial("hero", :object => @battle.challenger)
end

node :winner do
  partial("hero", :object => @battle.winner)
end

child :master_attacks do
  attributes :counter
end
