defmodule Wood.RoomController do
  use Wood.Web, :controller
  alias Wood.Repo
  alias Wood.Room

  def index(conn, _params) do
    rooms = Repo.all(Room)
    render(conn, "index.html", %{rooms: rooms})
  end

  def new(conn, _params) do
    changeset = Room.changeset(%Room{})
    render(conn, "new.html", %{changeset: changeset})
  end

  def create(conn, %{"room" => room_params}) do
    changeset = Room.changeset(%Room{}, room_params)

    case Repo.insert(changeset) do
      {:ok, _room} ->
        conn
        |> put_flash(:info, "Pokój stworzony.")
        |> redirect(to: room_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    render(conn, "show.html")
  end

  def delete(conn, %{"id" => id}) do
    room = Repo.get!(Room, id)
    Repo.delete!(room)
    conn
      |> put_flash(:info, "Pokój usunięty.")
      |> redirect(to: room_path(conn, :index))
  end
end
