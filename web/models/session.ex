defmodule Wood.Session do
  alias Wood.Repo
  alias Wood.User
  def login(params) do
    user = Repo.get_by!(User, %{email: String.downcase(params["email"])})
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _ ->:error
    end
  end

  defp authenticate(user, password) do
    Comeonin.Bcrypt.checkpw(password, user.crypted_password)
  end
end
