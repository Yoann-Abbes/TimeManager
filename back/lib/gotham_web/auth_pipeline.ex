defmodule GothamWeb.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :gotham,
  module: Gotham.Guardian,
  error_handler: Gotham.Auth.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end