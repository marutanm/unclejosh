namespace :develop do

  desc "load test ranking"
  task :load_ranking => :environment do
    require 'faker'
    helper = Object.new; helper.extend UnclejoshHelper;
    count = 100
    heros = (1..count).inject([]) do |heros, i|
      win_count = 0
      heros[i] ||= Hero.create_with_name "#{i} #{Faker::Name.name}"
      challenger = heros[i]
      (1..count).each do |j|
        next if i == j
        heros[j] ||= Hero.create_with_name "#{j} #{Faker::Name.name}"
        master = heros[j]
        result = helper.fight master, challenger
        win_count += 1 if result.winner == challenger
      end
      challenger.create_ranking_info initial_win: win_count, total_win: win_count
      helper.rank challenger
      heros
    end
    heros.each do |h|
      next unless h
      p "rank: #{Ranking.rank_of(h)}(win_count: #{h.ranking_info.initial_win}), name: #{h.name}(#{h.id})"
    end
  end

end
