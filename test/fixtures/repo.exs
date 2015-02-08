defmodule EctoAdmin.Test.Repo do
  def all(EctoAdmin.Test.User) do
    [
      %EctoAdmin.Test.User{name: "Test User", email: "test@example.com", created_at: datetime},
      %EctoAdmin.Test.User{name: "Example User", email: "user@example.com"}
    ]
  end

  defp datetime do
    %Ecto.DateTime{year: 2015, month: 12, day: 21, hour: 15, min: 18, sec: 52}
  end

end
