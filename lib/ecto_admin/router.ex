defmodule EctoAdmin.Router do
  @moduledoc """
  The router to handle all EctoAdmin requests. Currently it expects
  to be mounted at "/admin"
  """

  require EEx
  EEx.function_from_file :defp, :layout, "#{__DIR__}/templates/layout.eex", [:assigns]
  use Plug.Router

  plug :match
  plug :dispatch


  match _ do
    conn
    |> handle_request(conn.method, tl(conn.path_info))
    |> respond
  end

  defp respond({conn, status, content}) do
    send_resp(conn, status, layout(inner: content, models: models))
  end

  defp handle_request(conn, method, path = [resource | _tail]) do
    case get_resource(EctoAdmin.Config.models, resource) do
      nil      -> {conn, 404, "Resource Not Found"}
      resource -> EctoAdmin.Resource.render(conn, method, tl(path), resource)
    end
  end

  defp handle_request(conn, "GET", []) do
    {conn, 200, "Dashboard"}
  end

  defp handle_request(conn, _method, _path), do: {conn, 404, "Page Not Found"}

  def get_resource(models, resource) do
    if valid_resource?(models, resource) do
      {String.to_atom(resource), Keyword.get(models, String.to_atom(resource))}
    else
      nil
    end
  end

  defp valid_resource?(models, resource) do
    models
    |> Keyword.keys
    |> Enum.map(&to_string/1)
    |> Enum.member?(resource)
  end

  defp models do
    Keyword.keys(EctoAdmin.Config.models)
  end
end
