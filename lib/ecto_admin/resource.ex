defmodule EctoAdmin.Resource do
  @moduledoc """
  Module to render actions for a particular resource.
  """

  require EEx
  EEx.function_from_file :defp, :index, "#{__DIR__}/templates/index.eex", [:assigns]

  @doc """
    Render an action for a resource. Currently supported actions are:

        name            | method | path                      | resouce
        :-------------- | :----- | :------------------------ | :------
        index           | GET    | []                        | resource
        other           | _      | _                         | _

  """
  def render(method, path, resource) do
    render(method, path, resource, EctoAdmin.Config.repo)
  end

  defp render("GET", [], resource, repo) do
    fields = Map.keys(resource.__struct__) -- [:__state__, :__struct__]
    index([fields: fields, instances: repo.all(resource)])
  end
  defp render(_method, _path, _resource, _repo) do
    "This route is not implemented"
  end
end
