Fabricator(:hero) do
  name { Faker::Name.name }
  life { rand(1000) }
  strength { rand(100) }
  agility { rand(100) }
  agility { rand(100) }
end

