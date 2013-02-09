Fabricator(:turn) do
  counter { sequence(:counter, 1) }
  damage { rand(100) }
end

