defmodule ApiTransformer.PageController do
  use ApiTransformer.Web, :controller

  def index(conn, %{"search" => %{"url" => url, "type" => "xml"}}) do
    result = HTTPoison.get url
    |> transform_response_to_json

    render conn, "index.html"
  end

  def index(conn, %{"search" => %{"url" => url, "type" => "json"}}) do
    HTTPoison.get(url)
    |> transform_response_to_xml

    render conn, "index.html"
  end

  def index(conn, _params) do
    render conn, "index.html"
  end

  defp transform_response_to_xml({_ok, %HTTPoison.Response{body: results}} = response) do
    result = Poison.decode!(results)
    |> IO.inspect
    #|> XmlBuilder.generate

  end

  defp transform_response_to_json(response) do
  end
end
