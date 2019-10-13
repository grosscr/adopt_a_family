defmodule AdoptAFamily.Families do
  @moduledoc """
  The Families context.
  """

  import Ecto.Query, warn: false
  alias AdoptAFamily.Repo

  alias AdoptAFamily.Families.{Child, Family, FamilyGift, Gift}

  @doc """
  Creates a new family

  ## Examples

      iex> create_family(%{field: value})
      {:ok, %Family{}}

      iex> create_family(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_family(attrs \\ %{}) do
    %Family{}
    |> Family.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Adds a child to a family.

  ## Examples

      iex> add_child(%{field: value})
      {:ok, %User{}}

      iex> add_child(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def add_child(%Family{id: family_id}, attrs \\ %{}) do
    %Child{}
    |> Child.changeset(Map.put_new(attrs, :family_id, family_id))
    |> Repo.insert()
  end

  @doc """
  Adds a gift to a child or family.

  ## Examples

      iex> add_gift(%Child{}, %{field: value})
      {:ok, %Gift{}}

      iex> add_gift(%Family{}, %{field: value})
      {:ok, %FamilyGift{}}

      iex> add_gift(%Struct{}, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def add_gift(_owner, attrs \\ %{})
  def add_gift(%Family{id: family_id}, attrs) do
    %FamilyGift{}
    |> FamilyGift.changeset(Map.put_new(attrs, :family_id, family_id))
    |> Repo.insert()
  end
  def add_gift(%Child{id: child_id}, attrs) do
    %Gift{}
    |> Gift.changeset(Map.put_new(attrs, :child_id, child_id))
    |> Repo.insert()
  end

  @doc """
  Get all families

  ## Examples

      iex> all()
      [%Family{}]

  """
  def all() do
    from(f in Family,
      left_join: c in Child,
      on: [family_id: f.id],
      group_by: [f.id],
      select: [f, count(c.id)]
    )
    |> Repo.all
    |> Enum.map(fn [f, count] -> Map.put_new(f, :child_count, count) end)
  end

  @doc """
  Gets all the children and corresponding gifts for the provided family

  ## Examples

      iex> children_from_family(family_id)
      [%Child{}]

  """
  def children_from_family(family_id) do
    Repo.all(from(c in Child,
      join: f in assoc(c, :family),
      join: g in assoc(c, :gifts),
      where: f.id == ^family_id,
      preload: [gifts: g])
    )
  end
end
