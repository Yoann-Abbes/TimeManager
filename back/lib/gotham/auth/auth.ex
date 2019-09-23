defmodule Gotham.Auth do
  @moduledoc """
  The Auth context.
  """

  import Ecto.Query, warn: false
  
  alias Gotham.Repo
  alias Gotham.Roles
  alias Gotham.Auth.User
  alias Gotham.Auth
  alias Gotham.Guardian

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  def token_sign_in(username, password) do
    case email_password_auth(username, password) do
      {:ok, user} ->
      IO.inspect user
        Guardian.encode_and_sign(user)
      _ ->
        {:error, :unauthorized}
    end
  end

  defp email_password_auth(username, password) when is_binary(username) and is_binary(password) do
    user = get_by_username(username)
    verify_password(password, user)
  end

  defp verify_password(password, %User{} = user) when is_binary(password) do
    if Bcrypt.verify_pass(password, user.password) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end


  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_role!(id) do
    Repo.all(
      from b in "roles",
      where: b.id == ^id,
      select: b.label
    )
  end

  def get_user_by!(email, username), do: Repo.get_by!(User, email: email, username: username)

  def get_by_username(username), do: Repo.get_by!(User, username: username)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def update_team(%User{} = user, attrs) do
    IO.inspect attrs
    id = user.id
    from(u in User, where: u.id == ^id) |>
    Repo.update_all(push: [team: attrs])
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
