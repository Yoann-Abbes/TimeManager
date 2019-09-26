defmodule Gotham.WorkTest do
  use Gotham.DataCase

  alias Gotham.Work

  describe "workingtime" do
    alias Gotham.Work.WorkingTime

    @valid_attrs %{end: ~N[2010-04-17 14:00:00.000000], start: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{end: ~N[2011-05-18 15:01:01.000000], start: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{end: nil, start: nil}

    def working_time_fixture(attrs \\ %{}) do
      {:ok, working_time} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Work.create_working_time()

      working_time
    end

    # test "list_workingtime/0 returns all workingtime" do
    #   working_time = working_time_fixture()
    #   assert Work.list_workingtime() == [working_time]
    # end

    # test "get_working_time!/1 returns the working_time with given id" do
    #   working_time = working_time_fixture()
    #   assert Work.get_working_time!(working_time.id) == working_time
    # end

    # test "create_working_time/1 with valid data creates a working_time" do
    #   assert {:ok, %WorkingTime{} = working_time} = Work.create_working_time(@valid_attrs)
    #   assert working_time.end == ~N[2010-04-17 14:00:00.000000]
    #   assert working_time.start == ~N[2010-04-17 14:00:00.000000]
    # end

    # test "create_working_time/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} = Work.create_working_time(@invalid_attrs)
    # end

    # test "update_working_time/2 with valid data updates the working_time" do
    #   working_time = working_time_fixture()
    #   assert {:ok, working_time} = Work.update_working_time(working_time, @update_attrs)
    #   assert %WorkingTime{} = working_time
    #   assert working_time.end == ~N[2011-05-18 15:01:01.000000]
    #   assert working_time.start == ~N[2011-05-18 15:01:01.000000]
    # end

    # test "update_working_time/2 with invalid data returns error changeset" do
    #   working_time = working_time_fixture()
    #   assert {:error, %Ecto.Changeset{}} = Work.update_working_time(working_time, @invalid_attrs)
    #   assert working_time == Work.get_working_time!(working_time.id)
    # end

    # test "delete_working_time/1 deletes the working_time" do
    #   working_time = working_time_fixture()
    #   assert {:ok, %WorkingTime{}} = Work.delete_working_time(working_time)
    #   assert_raise Ecto.NoResultsError, fn -> Work.get_working_time!(working_time.id) end
    # end

    # test "change_working_time/1 returns a working_time changeset" do
    #   working_time = working_time_fixture()
    #   assert %Ecto.Changeset{} = Work.change_working_time(working_time)
    # end
  end
end
