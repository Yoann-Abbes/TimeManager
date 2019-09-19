defmodule GothamWeb.TokenPlug do
  import Plug.Conn
  alias Gotham.JWT

  def init(opts), do: opts

  def call(conn, _opts) do
    case JWT.decode(token_from_map(_opts, conn), System.get_env("JWT_KEY")) do
      { :success, %{token: token, claims: claims} } ->
        conn |> success(claims)
      { :error, error } ->
        conn |> forbidden
    end
  end

  defp jwt_from_cookie(conn) do
    conn
    |> Plug.Conn.get_req_header("cookie")
    |> List.first
    |> Plug.Conn.Cookies.decode
    |> token_from_map(conn)
  end

  defp token_from_map(%{"session_jwt" => jwt}, _conn), do: jwt

  defp token_from_map(_cookie_map, conn) do
    conn
    |> forbidden
  end

  defp forbidden(conn) do
    conn
    |> put_status(:unauthorized)
    |> Phoenix.Controller.render(GothamWeb.ErrorView, "401.html")
    |> halt
  end

  defp public_key do
    System.get_env("JWT_KEY")
    # your public key string that you read from a PEM file or stored in an env var or fetched from an endpoint
  end

  defp success(conn, token_payload) do
    assign(conn, :claims, token_payload.claims)
    |> assign(:jwt, token_payload.token)
  end
end