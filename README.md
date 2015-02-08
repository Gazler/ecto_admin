# EctoAdmin

EctoAdmin is a web based administration tool for Ecto models. It should work
with any Plug based project.

## Installation

Add the dependency to your `mix.exs` file:

```elixir
def deps
  [{:ecto_admin, "~> 0.0.1", github: "Gazler/ecto_admin"}]
end
```

You should also add this to the applications started in `mix.exs`:

```elixir
  def application do
    [mod: {EctoAdminExample, []},
     applications: [:logger, :postgrex, :ecto, :ecto_admin]]
  end
```

Add the following to your config:

```elixir
config :ecto_admin_example, EctoAdmin,
  repo:   EctoAdminExample.Repo,
  models: [users: EctoAdminExample.User, comments: EctoAdminExample.Comment]
```

Where `:admin_test` is the name of your OTP application, `repo` is the module
for your Ecto repo and models is a keyword list of paths and their related
model in the example config this would use `EctoAdminExample.User` for the
`/admin/users` path and `EctoAdminExample.Comment` for the
`/admin/comments` path.

### Phoenix

To Use EctoAdmin inside of a Phoenix project, you will need to add the
following to your `router.ex` file.

```elixir
  get "/admin*args", EctoAdmin.Router, :dispatch
```

This should be added at the root level and not inside of a `scope` block.

The config previously mentioned should be added to your `config` directory.
You can either create a new file and use `import_config` or just add it in
`config/config.exs`

An example repository for using EctoAdmin with Phoenix is available at
[https://github.com/Gazler/ecto_admin_example_phoenix](https://github.com/Gazler/ecto_admin_example_phoenix)

A commit with just the EctoAdmin configuration is available at
[https://github.com/Gazler/ecto_admin_example_phoenix/commit/9b42fbe666038b63a9833fba71aee5e508048e00](https://github.com/Gazler/ecto_admin_example_phoenix/commit/9b42fbe666038b63a9833fba71aee5e508048e00)

## Usage

Once you have added this you should be able to navigate to
[http://localhost:4000/admin](http://localhost:4000/admin) and you will see the
EctoAdmin dashboard at the top with a link to each of your configured
resources.
