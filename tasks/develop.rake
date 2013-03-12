namespace :develop do

  desc "load test ranking"
  task :load_ranking => :environment do
    require 'faker'
    helper = Object.new; helper.extend UnclejoshHelper;
    count = 100
    100.times do |i|
      begin
        hero = Hero.create_with_name Faker::Name.name
      rescue
        retry
      end
      hero.create_ranking_info win_point: i%10, total_win: i%10
      helper.rank hero
      p "rank: #{Ranking.rank_of(hero)}(win_count: #{hero.ranking_info.win_point}), name: #{hero.name}(#{hero.id})"
    end
  end

end
