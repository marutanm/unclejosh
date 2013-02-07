Fabricator(:battle) do
  masters { [ Fabricate(:hero) ] }
  challengers { [ Fabricate(:hero) ] }

  master_attacks { [] }
  challenger_attack { [] }
end

