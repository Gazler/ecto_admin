defmodule EctoAdmin.Resource do
  @moduledoc """
  Module to render actions for a particular resource.
  """

  require Plug.Conn
  require EEx
  EEx.function_from_file :defp, :index, "#{__DIR__}/templates/index.eex", [:assigns]
  EEx.function_from_file :defp, :new, "#{__DIR__}/templates/new.eex", [:assigns]

  @doc """
    Render an action for a resource. Currently supported actions are:

        name            | method | path                      | resouce
        :-------------- | :----- | :------------------------ | :------
        index           | GET    | []                        | resource
        other           | _      | _                         | _

  """
  def render(conn, method, path, resource) do
    render(conn, method, path, resource, EctoAdmin.Config.repo)
  end

  defp render(conn, "GET", [], {resource_path, resource}, repo) do
    response = index([
      fields: Map.keys(resource.__changeset__),
      instances: repo.all(resource),
      resource: resource_name(resource),
      resource_path: to_string(resource_path)
    ])
    {conn, 200, response}
  end
  defp render(conn, "GET", ["new"], {resource_path, resource}, repo) do
    response = new([
      fields: resource.__changeset__,
      resource: resource_name(resource),
      resource_path: to_string(resource_path)
    ])
    {conn, 200, response}
  end
  defp render(conn, "POST", [], {resource_path, resource}, repo) do
    conn = Plug.Conn.put_resp_header(conn, "Location", "/admin/#{resource_path}")
    repo.insert(struct_from_params(resource, conn.params))
    {conn, 302, ""}
  end
  defp render(conn, _method, _path, _resource, _repo) do
    {conn, 404, "This route is not implemented"}
  end

  defp resource_name(resource) do
    resource
    |> to_string
    |> String.split(".")
    |> Enum.at(-1)
  end

  defp struct_from_params(resource, params) do
    struct = resource.__struct__
    fields = Map.keys(resource.__changeset__) |> Enum.map(fn(field) -> to_string(field) end)
    Enum.filter(params, fn({key, _value}) -> Enum.member?(fields, key) end)
    |> Enum.filter(fn({_key, value}) -> value != "" end)
    |> Enum.reduce(struct, fn({key, value}, acc) -> Map.put(acc, String.to_atom(key), value) end)
  end
end
