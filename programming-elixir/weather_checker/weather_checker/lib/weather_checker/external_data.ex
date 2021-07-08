defmodule ExternalData do
    require XML

    defstruct temp_f: nil, temp_c: nil, relative_humidity: nil, latitude: nil
    @external_data_url "https://w1.weather.gov/xml/current_obs/KDTO.xml"
    @wanted_fields [:latitude]

    def get_weather_information() do
        HTTPoison.get!(@external_data_url)
        |> fn %HTTPoison.Response{ body: body } -> body end.()
        |> to_charlist()
        |> :xmerl_scan.string()
        |> elem(0)
        |> XML.xmlElement(:content)
        |> Enum.filter(fn child -> XML.xmlElement(child, :name) in @wanted_fields end)
        |> Enum.map(fn child -> {XML.xmlElement(child, :name), extract_text_content(child)} end)
        |> Enum.reduce(%ExternalData{}, &map_xml_text_to_model/2)
    end

    defp map_xml_text_to_model({:latitude, content}, acc), do
     %ExternalData{ acc | latitude: content |> to_string() |> Float.parse() |> elem(0)}
    end

    defp extract_text_content(elemnt_with_text) do
        [xml_text] = XML.xmlElement(elemnt_with_text, :content)
        XML.xmlText(xml_text, :value)
    end
end