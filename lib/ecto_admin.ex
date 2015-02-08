defmodule EctoAdmin do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    otp_app = Mix.Project.config[:app]

    children = [
      worker(EctoAdmin.Config, [otp_app, __MODULE__])
    ]

    opts = [strategy: :one_for_one, name: EctoAdmin.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
