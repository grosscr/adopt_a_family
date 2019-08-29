ExUnit.start()
Application.ensure_all_started(:double)
Ecto.Adapters.SQL.Sandbox.mode(AdoptAFamily.Repo, :manual)
