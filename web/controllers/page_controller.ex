defmodule Wood.PageController do
  use Wood.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
