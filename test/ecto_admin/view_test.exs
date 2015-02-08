defmodule EctoAdmin.ViewTest do
  use ExUnit.Case, async: true

  test "field/1 with en Ecto.DateTime returns a formatted string" do

    time = %Ecto.DateTime{year: 2015, month: 12, day: 21, hour: 15, min: 18, sec: 52}
    assert EctoAdmin.View.field(time) == "2015/12/21 15:18:52"
  end

  test "field/1 returns the field unaffected otherwise" do
    assert EctoAdmin.View.field("test") == "test"
    assert EctoAdmin.View.field(1) == 1
  end
end
