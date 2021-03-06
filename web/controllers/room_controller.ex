defmodule Wood.RoomController do
  use Wood.Web, :controller
  alias Wood.Repo
  alias Wood.Room
  import Wood.Session, only: [current_user: 1]
  plug Wood.Plugs.Authenticate

  def index(conn, _params) do
    rooms = Repo.all(Room) |> Repo.preload(:user)
    render(conn, "index.html", %{rooms: rooms})
  end

  def show(conn, %{"id" => id}) do
    room = Repo.get!(Room, id)
    query = from m in Wood.Message, where: m.room_id == ^id
    messages = Repo.all(query) |> Repo.preload(:user)

    render(conn, "show.html", %{room: room, messages: messages})
  end

  def new(conn, _params) do
    changeset = Room.changeset(%Room{})
    render(conn, "new.html", %{changeset: changeset})
  end

  def create(conn, %{"room" => room_params}) do
    room_params = Map.put(room_params, "user_id", current_user(conn).id)

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
  def delete(conn, %{"id" => id}) do
    room = Repo.get!(Room, id)
    Repo.delete!(room)
    conn
      |> put_flash(:info, "Pokój usunięty.")
      |> redirect(to: room_path(conn, :index))
  end
end
