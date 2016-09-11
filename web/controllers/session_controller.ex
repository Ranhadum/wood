defmodule  Wood.SessionController do
  use Wood.Web, :controller
  def new(conn, _params) do
    render(conn, "new.html")
  end
  def create(conn, %{"session" => session_params}) do
    case Wood.Session.login(session_params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Zalogowano")
        |> redirect(to: "/rooms")
      false ->
        conn
        |> put_flash(:info, "Błędne dane")
        |> render("new.html")
      end
  end
  def delete(conn,_params) do
      conn
      |> delete_session(:current_user)
      |> put_flash(:info, "Wylogowano")
      |> redirect(to: "/rooms")
  end
end
