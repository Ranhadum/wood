defmodule Wood.Session do
  alias Wood.Repo
  alias Wood.User
  def login(params) do
    user = Repo.get_by!(User, %{email: String.downcase(params["email"])})
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  defp authenticate(user, password) do
    Comeonin.Bcrypt.checkpw(password, user.crypted_password)
  end

  def current_user(conn) do
      id = Plug.Conn.get_session(conn, :current_user)
      if id, do: Repo.get(User, id)
  end

  def logged_in?(conn), do: !!current_user(conn)
end
