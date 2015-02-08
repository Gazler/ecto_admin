defmodule EctoAdmin.View do
  @moduledoc """
  Module containing the view helpers to be used in the templates
  """

  @doc """
  Output a field on an Ecto Model. If the field is an Ecto.DateTime then it will
  return a string representation of the time, otherwise it will return the
  passed in argument untouched.
  """
  def field(%Ecto.DateTime{year: year, month: month, day: day, hour: hour, min: min, sec: sec}) do
    "#{year}/#{month}/#{day} #{hour}:#{min}:#{sec}"
  end
  def field(value), do: value
end
