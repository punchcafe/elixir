defimpl String.Chars, for: WeatherData  do
  def to_string(%WeatherData{} = data) do
    """
    ******************* Weather Report ***************************
    temperature (c)   : #{data.temperature_c}
    humidity          : #{data.relative_humidity}
    latitude          : #{data.latitude}
    wind              : #{data.wind_description}
    """
  end
end