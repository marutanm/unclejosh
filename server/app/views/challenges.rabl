collection @challenges
attributes :id
node(:winner_id) {|challenge| challenge.winner.id }
node (:master) {|challenge| partial("hero", :object => challenge.master) }
