json.array!(@properties) do |property|
  json.partial! 'property', property: property
end
