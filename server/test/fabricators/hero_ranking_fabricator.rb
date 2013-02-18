win_count = rand(100)
Fabricator(:hero_ranking) do
  initial_win { win_count }
  total_win { win_count }
end
