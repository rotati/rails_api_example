module JSONHelpers
  def json(body)
    JSON.parse(body, symbolize_names: true)
  end
end
