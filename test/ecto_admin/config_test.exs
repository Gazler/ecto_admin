defmodule EctoAdmin.ConfigTest do
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

  test "getting the repo" do
    assert EctoAdmin.Config.repo == EctoAdmin.Test.Repo
  end

  test "getting the models" do
    assert EctoAdmin.Config.models == [users: EctoAdmin.Test.User, comments: EctoAdmin.Test.Comment]
  end

  test "updating config at runtime" do
    Application.put_env(:ecto_admin, EctoAdmin, [models: [users: EctoAdmin.Test.User]])
    EctoAdmin.Config.refetch_config
    assert EctoAdmin.Config.models == [users: EctoAdmin.Test.User]
  end
end
