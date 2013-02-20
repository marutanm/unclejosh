collection @challenges
attributes :id
node(:win) {|challenge| challenge.winner == @hero }
node (:master) {|challenge| partial("hero", :object => challenge.master) }
