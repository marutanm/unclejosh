# Helper methods defined here can be accessed in any controller or view in the application

# Unclejosh.helpers do

module UnclejoshHelper

  def fight(master, challenger)
    raise if master == challenger
    params = [master, challenger].inject({}) do |params, hero|
      params[hero.id] = {}
      params[hero.id][:cost] = 100
      params[hero.id][:life] = hero.life
      params
    end
    battle = Battle.create!(masters: [ master ], challengers: [ challenger ])
    catch(:done) do
      1.upto(1000) do |n|
        [master, challenger].each do |hero|
          params[hero.id][:cost] = params[hero.id][:cost] - hero.agility
          if params[hero.id][:cost] < 0
            damage = hero.strength + hero.possibility.sample
            enemy = ([master, challenger] - [hero]).first
            params[enemy.id][:life] = params[enemy.id][:life] - damage
            battle.turns.create!(counter: n, damage: damage, afc: hero == challenger)
            params[hero.id][:cost] = params[hero.id][:cost].abs
          end
          if params[master.id][:life] * params[challenger.id][:life] <= 0
            battle.winners = [ hero ]
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
