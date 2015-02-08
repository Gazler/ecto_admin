defmodule EctoAdmin.Config do
  @moduledoc """
  Module for fetching EctoAdmin config.

  This module expects config to be defined for the appliction, this is
  commonly inside of a config file:

      use Mix.Config

      config :some_application, EctoAdmin,
        repo: SomeApplication.Repo,
        models: [
          users: SomeApplication.User,
          comments: SomeApplication.Comment
        ]
  """

  use GenServer

  @doc """
  Starts an EctoAdmin confiration server.
  """
  def start_link(otp_app, module) do
    GenServer.start_link(__MODULE__, {otp_app, module}, name: __MODULE__)
  end

  @doc """
  Returns the Ecto repo for the host application.
  """
  def repo do
    GenServer.call(__MODULE__, {:get, :repo})
  end

  @doc """
  Returns the models for the host application. This is a keyword list:

      [users: SomeApplication.User, comments: SomeApplication.Comment]
  """
  def models do
    GenServer.call(__MODULE__, {:get, :models})
  end

  @doc """
  Refetches the application config.
  """
  def refetch_config do
    GenServer.cast(__MODULE__, :refetch_config)
  end

  def init({otp_app, module}) do
    {:ok, {otp_app, module, Application.get_env(otp_app, module)}}
  end

  def handle_call({:get, type}, _from, {otp_app, module, config} = state) do
    {:reply, Keyword.get(config, type), state}
  end

  def handle_cast(:refetch_config, {otp_app, module, _config}) do
    {:noreply, {otp_app, module, Application.get_env(otp_app, module)}}
  end
end
