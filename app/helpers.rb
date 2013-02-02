# Helper methods defined here can be accessed in any controller or view in the application

# Unclejosh.helpers do

module UnclejoshHelper

  def fight(master, challenger)
    raise if master == challenger
    master[:cost] = 100
    challenger[:cost] = 100
    battle = Battle.create!(masters: [ master ], challengers: [ challenger ])
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
    battle
  end

  def rank(hero)
    ranking = Ranking.challenge hero.ranking_info.initial_win
    ranking.heros << hero
    nil
  end

  def challenge_rank(challenger, count = 500)
    top = Ranking.all.desc(:win_count).limit(1).first.win_count
    win_count = 0
    while count > 0 do
      top.downto(0) do |i|
        heros = Ranking.find_by(win_count: i).heros
        heros.each do |hero|
          result = fight hero, challenger
          if result.winner == challenger
            win_count += 1
          else
            hero.ranking_info.total_win += 1
          end
          count -= 1
          break if count == 0
        end
        break if count == 0
      end
    end
    challenger.create_ranking_info initial_win: win_count, total_win: win_count

    rank challenger
    { rank: Ranking.rank_of(challenger), initial_win: win_count }
  end

end

Unclejosh.helpers UnclejoshHelper
