defmodule Wood.RegistrationTest do
  use Wood.IntegrationCase

    @tag :integration
    test "register new user" do
      navigate_to "/registrations/new"
      sign_up_form = find_element(:css, "form")

      sign_up_form
        |> find_within_element(:id, "user_email")
        |> fill_field("test@test.com")

      sign_up_form
        |> find_within_element(:id, "user_password")
        |> fill_field("12345")

        sign_up_form
        |> submit_element


        assert page_source =~ "Użytkownik stworzony"
  end
end
