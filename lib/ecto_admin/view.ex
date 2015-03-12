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

  def form_field(type, field) do
    form_field(type, field, "")
  end
  def form_field(Ecto.DateTime, field, value) do
  """
  <div class="row">
    <div class="col-xs-2">
      <input type="text" class="form-control" name="#{field}" value="#{value}" placeholder="yyyy">
    </div>
    <div class="col-xs-2">
      <input type="text" class="form-control" name="#{field}" value="#{value}" placeholder="mm">
    </div>
    <div class="col-xs-2">
      <input type="text" class="form-control" name="#{field}" value="#{value}" placeholder="dd">
    </div>
    <div class="col-xs-2">
      <input type="text" class="form-control" name="#{field}" value="#{value}" placeholder="hh">
    </div>
    <div class="col-xs-2">
      <input type="text" class="form-control" name="#{field}" value="#{value}" placeholder="mm">
    </div>
    <div class="col-xs-2">
      <input type="text" class="form-control" name="#{field}" value="#{value}" placeholder="ss">
    </div>
  </div>
  """ |> String.strip
  end
  def form_field(type, field, value) do
  """
  <input type="text" class="form-control" name="#{field}" value="#{value}">
  """ |> String.strip
  end
end
