defmodule Elixir_99 do
  @doc ~S"""
  P01 (*) Find the last box of a list.
  Returns the last element in `list` or `nil` if `list` is empty

  ## Examples
    iex> Elixir_99.last([])
    nil

    iex> Elixir_99.last([1])
    1

    iex> Elixir_99.last([1, 2, 3])
    3
  """
  @spec last([elem]) :: nil | elem when elem: var
  def last([]), do: nil
  def last([elem]), do: elem
  def last([_|t]), do: last(t)

  @doc ~S"""
  P02 (*) Find the last but one box of a list.
  Returns the last but one element in `list` or `nil` if list
  has less than one element

  ## Examples
    iex> Elixir_99.but_last([])
    nil

    iex> Elixir_99.but_last([1])
    nil

    iex> Elixir_99.but_last([1, 2])
    1

    iex> Elixir_99.but_last([1, 2, 3, 4])
    3
  """
  @spec but_last([elem]) :: nil | elem when elem: var
  def but_last([]), do: nil
  def but_last([_]), do: nil
  def but_last([ele, _]), do: ele
  def but_last([_ | t]), do: but_last(t)

  @doc ~S"""
  P03 (*) Find the K'th element of a list.
  Returns the K'th element of a `list` or `nil` if out of bound

  ## Examples
    iex> Elixir_99.nth([], 3)
    nil

    iex> Elixir_99.nth([1, 2, 3], 3)
    nil

    iex> Elixir_99.nth([1, 2, 3, 4], 0)
    1

    iex> Elixir_99.nth([1, 2, 3, 4], 1)
    2

    iex> Elixir_99.nth([1, 2, 3, 4], 3)
    4
  """
  @spec nth([elem], integer) :: nil | elem when elem: var
  def nth([], _), do: nil
  def nth([ele | _], 0), do: ele
  def nth([_ | t], idx), do: nth(t, idx - 1)

  @doc ~S"""
  P04 (*) Find the number of elements of a list.
  Returns the length of a `list`

  ## Examples
    iex> Elixir_99.len([])
    0

    iex> Elixir_99.len([1])
    1

    iex> Elixir_99.len([1, 2, 3, 4, 5])
    5
  """
  @spec len(list) :: integer
  def len(t), do: lenp(t, 0)
  defp lenp([], n), do: n
  defp lenp([_|t], n), do: lenp(t, n+1)

  @doc ~S"""
  P05 (*) Reverse a list.
  Returns a reversed `list` or `[]` if `list` is empty

  ## Examples
    iex> Elixir_99.reverse []
    []

    iex> Elixir_99.reverse [1]
    [1]

    iex> Elixir_99.reverse [1, 2, 3, 4, 5]
    [5, 4, 3, 2, 1]
  """
  @spec reverse([elem]) :: [elem] when elem: var
  def reverse(l), do: reverse_list(l, [])
  defp reverse_list([], l), do: l
  defp reverse_list([e|t], l), do: reverse_list(t, [e|l])

  @doc ~S"""
  P06 (*) Find out whether a list is a palindrome.
  Returns if a `list` is a palindrome.

  ## Examples
    iex> Elixir_99.palindrome []
    true

    iex> Elixir_99.palindrome [1]
    true

    iex> Elixir_99.palindrome [1, 2, 3]
    false

    iex> Elixir_99.palindrome [1, 2, 3, 2, 1]
    true
  """
  @spec palindrome(list) :: any
  def palindrome(l), do: l == reverse(l)

  @doc ~S"""
  P07 (**) Flatten a nested list structure.

  ## Examples
    iex> Elixir_99.flatten [1, 2, 3, 4, 5]
    [1, 2, 3, 4, 5]

    iex> Elixir_99.flatten [1, [2, 3], [4, [5]], []]
    [1, 2, 3, 4, 5]
  """
  @spec flatten(list) :: list
  def flatten([]), do: []
  def flatten([h|t]) do
    case h do
      [] -> flatten(t)
      [_|_] -> Enum.concat flatten(h), flatten(t)
      _ -> [h | flatten(t)]
    end
  end

  @doc ~S"""
  P08 (**) Eliminate consecutive duplicates of list elements.

  ## Examples
    iex> Elixir_99.compress []
    []

    iex> Elixir_99.compress [1]
    [1]

    iex> Elixir_99.compress [1, 1]
    [1]

    iex> Elixir_99.compress [1, 2]
    [1, 2]

    iex> Elixir_99.compress [1, 1, 2, 3, 3, 4, 4, 4, 4, 5]
    [1, 2, 3, 4, 5]
  """
  @spec compress(list) :: list
  def compress([]), do: []
  def compress([h]), do: [h]
  def compress([h1, h2 | t]) do
    cond do
      h1 == h2 -> compress([h1|t])
      true -> [h1 | compress([h2|t])]
    end
  end

  @doc ~S"""
  P09 (**) Pack consecutive duplicates of list elements into sublists.

  ## Examples
    iex> Elixir_99.pack [1, 1, 1, 1, 2, 3, 3, 1, 1, 4, 5, 5, 5, 5]
    [[1, 1, 1, 1], [2], [3, 3], [1, 1], [4], [5, 5, 5, 5]]

    iex> Elixir_99.pack []
    []

    iex> Elixir_99.pack [1]
    [[1]]
  """
  @spec pack(list) :: list
  def pack(l), do: pack_list(l, [])
  defp pack_list([], []), do: []
  defp pack_list([], l), do: [l]
  defp pack_list([h|t], []), do: pack_list(t, [h])
  defp pack_list([h|t], [h2|t2]) do
    cond do
      h == h2 -> pack_list(t, [h, h2 | t2])
      true -> [[h2|t2] | pack_list(t, [h])]
    end
  end

  @doc ~S"""
  P10 (*) Run-length encoding of a list.

  ## Examples
    iex> Elixir_99.encode ["a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e"]
    [{4, "a"}, {1, "b"}, {2, "c"}, {2, "a"}, {1, "d"}, {4, "e"}]

    iex> Elixir_99.encode []
    []

    iex> Elixir_99.encode [:a]
    [{1, :a}]
  """
  @spec encode(list) :: list
  def encode(l), do: encode_list(l, nil)
  defp encode_list([], nil), do: []
  defp encode_list([], {c, e}), do: [{c, e}]
  defp encode_list([h|t], nil), do: encode_list(t, {1, h})
  defp encode_list([h|t], {c, e}) do
    cond do
      h == e -> encode_list(t, {c+1, e})
      true -> [{c, e} | encode_list([h|t], nil)]
    end
  end

  @doc ~S"""
  P11 (*) Modified run-length encoding.

  ## Examples
    iex> Elixir_99.encode_modified [:a, :a, :a, :a, :b, :c, :c, :a, :a, :d, :e, :e, :e, :e ]
    [{4, :a}, :b , {2, :c}, {2, :a}, :d, {4, :e}]
  """
  @spec encode_modified(list) :: list
  def encode_modified(l) do
    Enum.map encode(l), (fn(elem) ->
      case elem do
        {1, e} -> e
        e -> e
      end
    end)
  end
end
