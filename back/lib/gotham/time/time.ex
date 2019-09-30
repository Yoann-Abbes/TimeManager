defmodule Gotham.Time do
  @moduledoc """
  The Time context.
  """

  import Ecto.Query, warn: false
  alias Gotham.Repo
  alias Gotham.Auth.User

  alias Gotham.Time.Clocks

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clocks{}, ...]

  """
  def list_clocks do
    Repo.all(Clocks)
  end

  @doc """
  Gets a single clocks.

  Raises `Ecto.NoResultsError` if the Clocks does not exist.

  ## Examples

      iex> get_clocks!(123)
      %Clocks{}

      iex> get_clocks!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clocks!(id), do: Repo.get!(Clocks, id)

  def get_clocks_by_user_id!(user_id) do
    Repo.all(
      from b in Clocks,
      where: b.user_id == ^user_id,
      order_by: [desc: :inserted_at],
      limit: 1,
      select: b
    )
  end


  def get_all_clocks_by_user_id!(user_id) do
    Repo.all(
      from b in Clocks,
      where: b.user_id == ^user_id,
      select: b
    )
  end


  def get_time_clocks_by!(user_id, status) do
    Repo.all(
      from b in Clocks,
      where: b.user_id == ^user_id,
      where: b.status == ^status,
      select: b.time
    )
  end

  def get_clocks_by!(user_id, status) do
    Repo.all(
      from b in Clocks,
      where: b.user_id == ^user_id,
      where: b.status == ^status,
      order_by: [desc: :inserted_at],
      limit: 1,
      select: b
    )
  end

  @doc """

  Creates a clocks.

  ## Examples

      iex> create_clocks(%{field: value})
      {:ok, %Clocks{}}

      iex> create_clocks(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clocks(%User{} = user, attrs \\ %{}) do
    attrs = Map.put(attrs, "user_id", user.id)
    %Clocks{}
    |> Clocks.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clocks.

  ## Examples

      iex> update_clocks(clocks, %{field: new_value})
      {:ok, %Clocks{}}

      iex> update_clocks(clocks, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clocks(%Clocks{} = clocks, attrs) do
    clocks
    |> Clocks.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Clocks.

  ## Examples

      iex> delete_clocks(clocks)
      {:ok, %Clocks{}}

      iex> delete_clocks(clocks)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clocks(%Clocks{} = clocks) do
    Repo.delete(clocks)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clocks changes.

  ## Examples

      iex> change_clocks(clocks)
      %Ecto.Changeset{source: %Clocks{}}

  """
  def change_clocks(%Clocks{} = clocks) do
    Clocks.changeset(clocks, %{})
  end
end
