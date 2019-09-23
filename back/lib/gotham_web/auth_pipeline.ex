defmodule GothamWeb.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :gotham,
  module: GothamWeb.Guardian,
  error_handler: GothamWeb.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end