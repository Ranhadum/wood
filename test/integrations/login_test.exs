defmodule Wood.LoginTest do
  use Wood.IntegrationCase
  alias Wood.User
  alias Wood.Repo
    @tag :integration
    test "login" do
      User.changeset(%User{}, %{email: "test@test.com", password: "12345"})
      |> Wood.Registration.create

      navigate_to "/login/"

      login_form = find_element(:css, "form")

      login_form
        |> find_within_element(:id, "session_email")
        |> fill_field("test@test.com")

        login_form
        |> find_within_element(:id, "session_password")
        |> fill_field("12345")

        login_form
        |> submit_element


      assert page_source =~ "Zalogowano"
  end
end
