defmodule EctoAdmin.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts EctoAdmin.Router.init([])

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

  test "when using a valid resource" do
    conn = conn(:get, "/admin/users")
    conn = EctoAdmin.Router.call(conn, @opts)
    assert conn.status == 200
    assert conn.resp_body =~ "Test User"
  end

  test "when using an unrecognized resource" do
    conn = conn(:get, "/admin/foo")
    conn = EctoAdmin.Router.call(conn, @opts)
    assert conn.status == 404
    assert conn.resp_body =~ "Resource Not Found"
  end

  test "when using the dashboard path" do
    conn = conn(:get, "/admin")
    conn = EctoAdmin.Router.call(conn, @opts)
    assert conn.status == 200
    assert conn.resp_body =~ "Dashboard"
  end

  test "when visiting any other page" do
    conn = conn(:post, "/admin")
    conn = EctoAdmin.Router.call(conn, @opts)
    assert conn.status == 404
    assert conn.resp_body =~ "Page Not Found"
  end
end
