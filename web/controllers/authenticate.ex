defmodule Wood.Plugs.Authenticate do
  import Plug.Conn
  import Wood.Router.Helpers
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Wood.Session, only: [current_user: 1]

  def init(default), do: default

  def call(conn, default) do
    case current_user(conn) do
      nil ->
        conn
          |> put_flash(:error, "Musisz się zalogować by zobaczyć tę stronę.")
          |> redirect(to: session_path(conn, :new))
      _ -> conn
    end
  end
end
