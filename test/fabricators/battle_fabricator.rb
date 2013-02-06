Fabricator(:battle) do
  masters { [ Fabricate(:hero) ] }
  challengers { [ Fabricate(:hero) ] }
end

