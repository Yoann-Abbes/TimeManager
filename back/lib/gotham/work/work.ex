defmodule Gotham.Work do
  @moduledoc """
  The Work context.
  """

  import Ecto.Query, warn: false
  alias Gotham.Repo
  alias Gotham.Work.WorkingTime
  alias Gotham.Auth.User

  @doc """
  Returns the list of workingtime.

  ## Examples

      iex> list_workingtime()
      [%WorkingTime{}, ...]

  """
  def list_workingtime do
    Repo.all(WorkingTime)
  end

  def get_working_time_list_by(user_id) do
    Repo.all(
      from b in WorkingTime,
      where: b.user_id == ^user_id,
      select: b
    )

  end

  def get_working_time_list_by_ids(user_id, id) do
    Repo.all(
      from b in WorkingTime,
      where: b.user_id == ^user_id,
      where: b.id == ^id,
      select: b
    )

  end

  @doc """
  Gets a single working_time.

  Raises `Ecto.NoResultsError` if the Working time does not exist.

  ## Examples

      iex> get_working_time!(123)
      %WorkingTime{}

      iex> get_working_time!(456)
      ** (Ecto.NoResultsError)

  """
  def get_working_time!(id), do: Repo.get!(WorkingTime, id)

  def get_working_time_by_start_end(user_id, start, nd) do
    Repo.all(
    from b in WorkingTime,
    where: b.user_id == ^user_id,
    where: b.end == ^nd,
    where: b.start == ^start,
    select: b
  )
  end #: Repo.get_by!(WorkingTime, user_id: user_id, start: start, end: nd)

  def get_working_time_by_start(user_id, start) do

    Repo.all(
    from b in WorkingTime,
    where: b.user_id == ^user_id,
    where: b.start == ^start,
    select: b
  )

  end#: Repo.get_by!(WorkingTime, user_id: user_id, start: start)
  def get_working_time_by_end(user_id, nd) do

  Repo.all(
    from b in WorkingTime,
    where: b.user_id == ^user_id,
    where: b.end == ^nd,
    select: b
  )

  end #Repo.get_by!(WorkingTime, user_id: user_id, end: nd)
  @doc """
  Creates a working_time.

  ## Examples

      iex> create_working_time(%{field: value})
      {:ok, %WorkingTime{}}

      iex> create_working_time(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_working_time(%User{} = user, attrs) do

    attrs = Map.put(attrs, "user_id", user.id)

    IO.inspect attrs
    %WorkingTime{}
    |> WorkingTime.changeset(attrs)
    |> Repo.insert()

  end

  @doc """
  Updates a working_time.

  ## Examples

      iex> update_working_time(working_time, %{field: new_value})
      {:ok, %WorkingTime{}}

      iex> update_working_time(working_time, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_working_time(%WorkingTime{} = working_time, attrs) do
    working_time
    |> WorkingTime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a WorkingTime.

  ## Examples

      iex> delete_working_time(working_time)
      {:ok, %WorkingTime{}}

      iex> delete_working_time(working_time)
      {:error, %Ecto.Changeset{}}

  """
  def delete_working_time(%WorkingTime{} = working_time) do
    Repo.delete(working_time)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking working_time changes.

  ## Examples

      iex> change_working_time(working_time)
      %Ecto.Changeset{source: %WorkingTime{}}

  """
  def change_working_time(%WorkingTime{} = working_time) do
    WorkingTime.changeset(working_time, %{})
  end
end
