defmodule Wood.UserTest do
  use Wood.ModelCase

  alias Wood.User

  @valid_attrs %{password: "12345", email: "test@test.com"}
  @empty_attrs %{}
  @invalid_attrs %{password: "1", email: "1"}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with empty attributes" do
    changeset = User.changeset(%User{}, @empty_attrs)
    assert changeset.errors[:password] == {"can't be blank", []}
    assert changeset.errors[:email] == {"can't be blank", []}
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    assert changeset.errors[:password] == {"should be at least %{count} character(s)", [count: 5]}
    assert changeset.errors[:email] == {"has invalid format", []}
  end
end
