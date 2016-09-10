defmodule Wood.RegistrationController do
    use Wood.Web, :controller
    alias Wood.User
    def new(conn, _params) do
      changeset = User.changeset(%User{})
      render(conn, %{changeset: changeset})
    end

    def create(conn, %{"user" => user_params}) do
      changeset = User.changeset(%User{}, user_params)

      case Wood.Registration.create(changeset) do
        {:ok, _user} ->
          conn
          |> put_flash(:info, "Użytkownik stworzony.")
          |> redirect(to: "/rooms")
        {:error, changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end
