Fabricator(:ranking) do
  win_count { rand(100) }
  rank      { rand(100) }
end
