collection @challenges
attributes :id
node(:master_id) { |challenge| challenge.master.id }
node(:win) {|challenge| challenge.winner == @hero }
