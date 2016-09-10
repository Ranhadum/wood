defmodule Wood.IntegrationCase do
  use ExUnit.CaseTemplate
  use Hound.Helpers

  using do
    quote do
      use Hound.Helpers
      import Wood.IntegrationCase

      hound_session
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Wood.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Wood.Repo, {:shared, self()})
    end

    :ok
   end
end
