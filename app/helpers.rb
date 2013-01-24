# Helper methods defined here can be accessed in any controller or view in the application

# Unclejosh.helpers do

module UnclejoshHelper

  def fight(master, challenger)
    raise if master == challenger
    master[:cost] = 100
    challenger[:cost] = 100
    battle = Battle.create!(masters: [master], challengers: [challenger]) do |battle|
      catch(:done) do
        1.upto(1000) do |n|
          [master, challenger].each do |hero|
            hero[:cost] = hero[:cost] - hero.agility
            if hero[:cost] < 0
              damage = hero.strength + hero.possibility.sample
              enemy = ([master, challenger] - [hero]).first
              enemy.life = enemy.life - damage
              battle.turns.create!(counter: n, damage: damage, afc: hero == challenger)
              hero[:cost] = hero[:cost].abs
            end
            if master.life * challenger.life <= 0
              battle.winners = [hero]
              throw :done
              break
            end
          end
        end
      end
    end
    battle
  end

end

Unclejosh.helpers UnclejoshHelper
