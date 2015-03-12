defmodule EctoAdmin.Test.User do
  defstruct name: "", email: "", created_at: %Ecto.DateTime{}, updated_at: %Ecto.DateTime{}

  def __changeset__ do
    %{name: :string, email: :string, created_at: Ecto.DateTime, updated_at: Ecto.DateTime}
  end
end
