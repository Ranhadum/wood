defmodule Wood.Room do
  use Wood.Web, :model

  schema "rooms" do
    field :name, :string
    has_many :messages, Wood.Message
    belongs_to :user, Wood.User


  timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :user_id])
    |> validate_required([:name, :user_id])
    |> validate_length(:name, min: 4, max: 16)
  end
end
