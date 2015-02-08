Enum.each(["user", "comment", "repo"], fn (name) ->
  Code.require_file("#{name}.exs", "#{__DIR__}/fixtures")
end)
ExUnit.start()
