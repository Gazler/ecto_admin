defmodule EctoAdmin.ResourceTest do
  use ExUnit.Case, async: true

  setup do
    config = [
      repo: EctoAdmin.Test.Repo,
      models: [
        users: EctoAdmin.Test.User,
        comments: EctoAdmin.Test.Comment
      ]
    ]
    Application.put_env(:ecto_admin, EctoAdmin, config)
    EctoAdmin.Config.refetch_config
    :ok
  end

  test "render/3 with a route that is not implemented" do
    assert EctoAdmin.Resource.render("PUT", [], EctoAdmin.Test.User) == "This route is not implemented"
  end

  test "render/3 with an index route" do
    content = EctoAdmin.Resource.render("GET", [], EctoAdmin.Test.User)
    assert content =~ "<th>email</th>"
    assert content =~ "<th>name</th>"
    assert content =~ "<th>created_at</th>"
    assert content =~ "<th>updated_at</th>"

    assert content =~ "<td>Test User</td>"
    assert content =~ "<td>test@example.com</td>"
    assert content =~ "<td>2015/12/21 15:18:52</td>"

    assert content =~ "<td>Example User</td>"
    assert content =~ "<td>user@example.com</td>"
  end
end
