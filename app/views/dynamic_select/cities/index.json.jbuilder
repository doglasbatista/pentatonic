json.array!(@cities) do |cities|
  json.extract! city, :name, :id
end