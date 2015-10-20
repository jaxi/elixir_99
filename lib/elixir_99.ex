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
  @doc ~S"""
  P12 (**) Decode a run-length encoded list.

  ## Examples
    iex> Elixir_99.decode [{4, :a}, :b , {2, :c}, {2, :a}, :d, {4, :e}]
    [:a, :a, :a, :a, :b, :c, :c, :a, :a, :d, :e, :e, :e, :e ]
  """
  @spec decode(list) :: list
  def decode(l) do
    (Enum.map l, (fn(elem) ->
      case elem do
        {c, e} -> List.duplicate(e, c)
        _ -> [elem]
      end
    end)) |> List.flatten
  end

  @doc ~S"""
  # P13 (**) Run-length encoding of a list (direct solution).

  ## Examples
    iex> Elixir_99.run_length [:a, :a, :a, :a, :b, :c, :c, :a, :a, :d, :e, :e, :e, :e ]
    [{4, :a}, :b , {2, :c}, {2, :a}, :d, {4, :e}]

    iex> Elixir_99.run_length []
    []

    iex> Elixir_99.run_length [:a]
    [:a]

    iex> Elixir_99.run_length [:a, :a]
    [{2, :a}]
  """
  @spec run_length(list) :: list
  def run_length(l) do
    Enum.map encode_list(l, nil), (fn(elem) ->
      case elem do
        {1, e} -> e
        e -> e
      end
    end)
  end

  @doc ~S"""
  # P14 (*) Duplicate the elements of a list.

  ## Examples
    iex> Elixir_99.dupli []
    []

    iex> Elixir_99.dupli [1, 2, 3, 3, 4]
    [1, 1, 2, 2, 3, 3, 3, 4, 4]

    iex> Elixir_99.dupli [1, 2, 3, 3, 4, 4]
    [1, 1, 2, 2, 3, 3, 3, 4, 4, 4]
  """
  @spec dupli(list) :: list
  def dupli([]), do: []
  def dupli([h]), do: [h, h]
  def dupli([h1, h2 | t]) do
    cond do
      h1 == h2 -> [h1 | dupli([h2|t])]
      true -> [h1, h1 | dupli([h2|t])]
    end
  end

  @doc ~S"""
  P15 (**) Replicate the elements of a list a given number of times.

  ## Examples
    iex> Elixir_99.repli [1, 2, 3], 3
    [1, 1, 1, 2, 2, 2, 3, 3, 3]
  """
  @spec repli(list, integer) :: list
  def repli(l, n) do
    Enum.map(l, (fn(ele) -> List.duplicate(ele, n) end))
    |> List.flatten
  end

  @doc ~S"""
  P16 (**) Drop every N'th element from a list.

  ## Examples
    iex> Elixir_99.drop [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 3
    [1, 2, 4, 5, 7, 8, 10]

    iex> Elixir_99.drop [1, 2, 3], -1
    [1, 2, 3]

    iex> Elixir_99.drop [1, 2, 3], 4
    [1, 2, 3]
  """
  @spec drop(list, integer) :: list
  def drop(l, i) when i <= 0 do
    l
  end
  def drop(l, n) do
    l |> Enum.with_index |> Enum.filter_map (fn(e) ->
      {_, i } = e
      rem(i + 1, n) != 0
    end), (fn(e) ->
      {ele, _} = e
      ele
    end)
  end

  @doc ~S"""
  P17 (*) Split a list into two parts;
  the length of the first part is given.

  ## Examples
    iex> Elixir_99.split [:a, :b, :c, :d, :e, :f, :g, :h, :i, :j], 3
    [[:a, :b, :c], [:d, :e, :f, :g, :h, :i, :j]]

    iex> Elixir_99.split [:a, :b, :c], 3
    [[:a, :b, :c], []]

    iex> Elixir_99.split [:a, :b, :c], 4
    [[:a, :b, :c], []]

    iex> Elixir_99.split [:a, :b, :c], 0
    [[], [:a, :b, :c]]

    iex> Elixir_99.split [:a, :b, :c], -2
    [[], [:a, :b, :c]]
  """
  @spec split(list, integer) :: list
  def split(l, i), do: split_list([], l, i)
  defp split_list(l1, l2, i) when i <= 0 do
    [l1, l2]
  end
  defp split_list(l1, [], _), do: [l1, []]
  defp split_list(l1, [h|t], i), do: split_list(l1 ++ [h], t, i - 1)

  @doc ~S"""
  P18 (**) Extract a slice from a list.

  Examples:
    iex> Elixir_99.slice [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 3, 7
    [3, 4, 5, 6, 7]

    iex> Elixir_99.slice [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 3, 2
    []

    iex> Elixir_99.slice [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], -3, 2
    []
  """
  @spec slice(list, integer, integer) :: list
  def slice(l, i, j), do: slice_list(l, i, j)
  defp slice_list(_, i, j) when (i > j or i <= 0) do
    []
  end
  defp slice_list([_|t], i, j) when i > 1 do
    slice_list(t, i - 1, j - 1)
  end
  defp slice_list(l, _, j) do
    take([], l, j)
  end
  defp take(r, [], _), do: r
  defp take(r, _, 0), do: r
  defp take(r, [h|t], n), do: take(r ++ [h], t, n - 1)

  @doc ~S"""
  P19 (**) Rotate a list N places to the left.

  ## Examples
    iex> Elixir_99.rotate [:a, :b, :c, :d, :e, :f, :g, :h], 3
    [:d, :e, :f, :g, :h, :a, :b, :c]

    iex> Elixir_99.rotate [:a, :b, :c, :d, :e, :f, :g, :h], -2
    [:g, :h, :a, :b, :c, :d, :e, :f]

    iex> Elixir_99.rotate [:a, :b, :c, :d, :e, :f, :g, :h], 9
    [:a, :b, :c, :d, :e, :f, :g, :h]
  """
  @spec rotate(list, integer) :: list
  def rotate(l, i) when i <= 0 do
    rotate(l, length(l) + i)
  end
  def rotate(l, i) when i > length(l) do
    l
  end
  def rotate(l, i) do
    [l1, l2] = split(l, i)
    Enum.concat(l2, l1)
  end

  @doc ~S"""
  P20 (*) Remove the K'th element from a list.

  ## Examples
    iex> Elixir_99.remove_at [:a, :b, :c, :d], 2
    [:a, :c, :d]

    iex> Elixir_99.remove_at [:a, :b, :c, :d], 5
    [:a, :b, :c, :d]
  """
  @spec remove_at(list, integer) :: list
  def remove_at(l, i) when i <= 0 do
    l
  end
  def remove_at([], 1), do: []
  def remove_at([_|t], 1), do: t
  def remove_at([h|t], i), do: [h | remove_at(t, i - 1)]

  @doc ~S"""
  P21 (*) Insert an element at a given position into a list.

  ## Examples
    iex> Elixir_99.insert_at [:a, :b, :c, :d], :abc, 2
    [:a, :abc, :c, :d]

    iex> Elixir_99.insert_at [:a, :b, :c, :d], :abc, 4
    [:a, :b, :c, :abc]

    iex> Elixir_99.insert_at [:a, :b, :c, :d], :abc, 5
    [:a, :b, :c, :d]

    iex> Elixir_99.insert_at [:a, :b, :c, :d], :abc, 0
    [:a, :b, :c, :d]
  """
  @spec insert_at(list, any, integer) :: list
  def insert_at(l, _, i) when i <= 0 do
    l
  end
  def insert_at([_|t], e, 1), do: [e|t]
  def insert_at([], _, _), do: []
  def insert_at([h|t], e, i), do: [h | insert_at(t, e, i - 1)]

  @doc ~S"""
  P22 (*) Create a list containing all integers within a given range.

  ## Examples
    iex> Elixir_99.range(4, 9)
    [4, 5, 6, 7, 8, 9]

    iex> Elixir_99.range(-3, 2)
    [-3, -2, -1, 0, 1, 2]

    iex> Elixir_99.range(2, 2)
    [2]

    iex> Elixir_99.range(3, 2)
    []
  """
  @spec range(integer, integer) :: list
  def range(i, j) when i > j do
    []
  end
  def range(i, j), do: [i | range(i + 1, j)]

  @doc ~S"""
  P23 (**) Extract a given number of randomly selected elements from a list.

  ## Examples
    iex> Elixir_99.rnd_select([:a, :b, :c, :d, :e, :f, :g, :h], 3) |> length
    3
  """
  @spec rnd_select(list, integer) :: list
  def rnd_select(l, i), do: rnd_select(l, i, [])
  defp rnd_select([], _, res), do: res
  defp rnd_select(_, i, res) when i <= 0 do
    res
  end
  defp rnd_select(l, i, res) do
    rand = length(l) |> :random.uniform
    [h|t] = move_ahead(l, rand)
    rnd_select(t, i - 1, [h|res])
  end
  defp move_ahead([h|t], 1), do: [h|t]
  defp move_ahead([h|t], i) do
    [h2|t2] =move_ahead(t, i - 1)
    [h2, h | t2]
  end

  @doc ~S"""
  P24 (*) Lotto: Draw N different random numbers from the set 1..M.

  ## Examples
    iex> Elixir_99.lotto_select(6, 49) |> length
    6
  """
  @spec lotto_select(integer, integer) :: list
  def lotto_select(n, m), do: range(1, m) |> rnd_select n

  @doc ~S"""
  P25 (*) Generate a random permutation of the elements of a list.

  ## Examples
    iex> Elixir_99.rnd_permu([:a, :b, :c, :d, :e, :f]) |> length
    6
  """
  @spec rnd_permu(list) :: list
  def rnd_permu(l), do: rnd_select(l, length(l))

  @doc ~S"""
  P26 (**) Generate the combinations of K distinct objects chosen from the N elements of a list

  ## Examples
    iex> Elixir_99.combination([:a, :b, :c, :d, :e, :f] , 1) |> length
    6

    iex> Elixir_99.combination([:a, :b, :c, :d, :e, :f] , 2) |> length
    15

    iex> Elixir_99.combination([:a, :b, :c, :d, :e, :f] , 3) |> length
    20
  """
  @spec combination(list, integer) :: list
  def combination(l, k), do: combination(l, k, [], [])
  defp combination(l, k, res, proto) when k > length(l) + length(proto) do
    res
  end
  defp combination(_, k, res, proto) when length(proto) == k do
    res ++ [proto]
  end
  defp combination([h|t], k, res, proto) do
    combination(t, k, res, proto ++ [h]) ++ combination(t, k, res, proto)
  end

  @doc ~S"""
  P27 (**) Group the elements of a set into disjoint subsets.

  ## Examples
    iex> Elixir_99.group([:aldo, :beat, :carla, :david, :evi, :flip, :gary, :hugo, :ida], [2, 2, 5]) |> List.first
    [[:aldo, :beat], [:carla, :david], [:evi, :flip, :gary, :hugo, :ida]]
  """
  @spec group(list, list) :: list
  def group(l, s), do: group(l, s, [], List.duplicate([], length(s)))
  defp group(l, s, res, proto) do
    cond do
      filled?(s, proto) ->
        res ++ [proto]
      capacity(proto) + length(l) < Enum.sum(s)  or exceed_capacity?(s, proto) ->
        res
      true ->
        [h|t] = l
        Enum.reduce possible_fill(proto, h), group(t, s, res, proto), (
          fn(x, acc) -> acc ++ group(t, s, res, x)
        end)
    end
  end
  defp possible_fill(l, ele) do
    l |> Enum.with_index |> Enum.map (fn({e, index}) ->
      List.update_at l, index, (fn(_) -> e ++ [ele] end)
    end)
  end
  defp filled?(subset, comb) do
    List.zip([subset, comb]) |> Enum.all?(fn({s, c}) -> s == length(c) end)
  end
  defp exceed_capacity?(subset, comb) do
    List.zip([subset, comb]) |> Enum.any?(fn({s, c}) -> s < length(c) end)
  end
  def capacity(comb) do
    Enum.map(comb, fn(c) -> length(c) end)
    |> Enum.reduce (fn(x, acc) -> x + acc end)
  end

  # P28 (**) Sorting a list of lists according to length of sublists

  @doc ~S"""
  We suppose that a list contains elements that are lists themselves.
  The objective is to sort the elements of this list according to their length. E.g. short lists first, longer lists later, or vice versa.

  ## Examples
    iex> Elixir_99.lsort [[:a, :b, :c], [:d, :e], [:f, :g, :h], [:d, :e], [:i, :j, :k, :l], [:m, :n], [:o]]
    [[:o], [:d, :e], [:d, :e], [:m, :n], [:a, :b, :c], [:f, :g, :h], [:i, :j, :k, :l]]
  """
  @spec lsort(list) :: list
  def lsort(l) do
    Enum.sort l, (fn(l1, l2) ->
      len1 = length(l1)
      len2 = length(l2)
      (len1 < len2) or (len1 == len2 and l1 < l2)
    end)
  end

  @doc ~S"""
  Again, we suppose that a list contains elements that are lists themselves.
  But this time the objective is to sort the elements of this list according to their length frequency;
  i.e., in the default, where sorting is done ascendingly, lists with rare lengths are placed first, others with a more frequent length come later.

  ## Examples
    iex> Elixir_99.lfsort [[:a, :b, :c], [:d, :e], [:f, :g, :h], [:d, :e], [:i, :j, :k, :l], [:m, :n], [:o]]
    [[:i, :j, :k, :l], [:o], [:a, :b, :c], [:f, :g, :h], [:d, :e], [:d, :e], [:m, :n]]
  """
  @spec lfsort(list) :: list
  def lfsort(l) do
    f = freq(l)
    Enum.sort l, (fn(l1, l2) ->
      len1 = length(l1)
      len2 = length(l2)
      Dict.get(f, len1) <= Dict.get(f, len2)
    end)
  end
  defp freq(l) do
    Enum.reduce l, HashDict.new, (fn(x, dict) ->
      len = length(x)
      case Dict.get dict, len do
        nil -> Dict.put dict, len, 1
        x -> Dict.put dict, len, x + 1
      end
    end)
  end

  @doc ~S"""
  P31 (**) Determine whether a given integer number is prime.

  ## Examples
    iex> Elixir_99.prime? 7
    true

    iex> Elixir_99.prime? 2
    true

    iex> Elixir_99.prime? 4
    false
  """
  @spec prime?(integer) :: boolean
  def prime?(n) do
    cond do
      n <= 1 -> false
      n == 2 -> true
      true -> 2..(n |> :math.sqrt |> round) |> Enum.all?(fn(i) -> rem(n, i) != 0 end)
    end
  end

  @doc """
  P32 (**) Determine the greatest common divisor of two positive integer numbers.

  ## Examples
    iex> Elixir_99.gcd(36, 63)
    9
  """
  @spec gcd(integer, integer) :: integer
  def gcd(a, b) do
    cond do
      b == 0 -> a
      true -> gcd(b, rem(a, b))
    end
  end

  @doc ~S"""
  P33 (*) Determine whether two positive integer numbers are coprime.

  ## Examples
    iex> Elixir_99.coprime 35, 54
    true

    iex> Elixir_99.coprime 7, 97
    true

    iex> Elixir_99.coprime 21, 14
    false
  """
  @spec coprime(integer, integer) :: integer
  def coprime(a, b), do: gcd(a, b) == 1

  @doc ~S"""
  P34 (**) Calculate Euler's totient function phi(m).

  ## Examples
    iex> Elixir_99.totient_phi 10
    4

    iex> Elixir_99.totient_phi 36
    12
  """
  @spec totient_phi(integer) :: integer
  def totient_phi(n) do
    case n do
      1 -> 1
      _ ->
        collect_prime(2, [], n)
        |> (Enum.filter (fn(x) -> rem(n, x) == 0 end))
        |> (Enum.reduce n, (fn(x, acc) -> acc * (x - 1)/ x end))
        |> round
    end
  end
  defp collect_prime(i, plist, n) do
    cond do
      i == n + 1 ->
        plist
      Enum.all?(plist, fn(p) -> rem(i, p) != 0 end) ->
        collect_prime(i + 1, [i|plist], n)
      true ->
        collect_prime(i + 1, plist, n)
    end
  end

  @doc ~S"""
  P35 (**) Determine the prime factors of a given positive integer.

  ## Examples
    iex> Elixir_99.prime_factors 315
    [3, 3, 5, 7]
  """
  @spec prime_factors(integer) :: list
  def prime_factors(n) do
    plist = collect_prime(2, [], n)
    |> (Enum.filter fn(x) -> rem(n, x) == 0 end)
    prime_factors(n, plist, [])
  end
  def prime_factors(n, plist, res) do
    case n do
      1 -> res
      _ ->
        [h|t] = plist
        cond do
          rem(n, h) == 0 -> prime_factors(div(n, h), plist, [h|res])
          true -> prime_factors(n, t, res)
        end
    end
  end

  @doc ~S"""
  P36 (**) Determine the prime factors of a given positive integer (2).

  ## Examples
   iex> Elixir_99.prime_factors_mult 315
   [{3, 2}, {5, 1}, {7, 1}]
  """
  @spec prime_factors_mult(integer) :: list
  def prime_factors_mult(n) do
    plist = collect_prime(2, [], n)
      |> (Enum.filter &(rem(n, &1) == 0))
    pt = Enum.map(plist, &(p_times(n, &1, 0)))
    Enum.zip(plist, pt) |> reverse
  end
  defp p_times(n, p, i) do
    cond do
      rem(n, p) == 0 -> p_times(div(n, p), p, i + 1)
      true -> i
    end
  end

  @doc ~S"""
  P39 (*) A list of prime numbers.

  ## Examples
    iex> Elixir_99.prime_list(6, 15)
    [7, 11, 13]
  """
  @spec prime_list(integer, integer) :: list
  def prime_list(lower, upper) do
    collect_prime(2, [], upper)
    |> reverse
    |> Enum.filter &(&1 >= lower)
  end

  @doc ~S"""
  P40 (**) Goldbach's conjecture.

  ## Examples
    iex> Elixir_99.goldbach 28
    {5, 23}
  """
  @spec goldbach(integer) :: list
  def goldbach(n) do
    plist = collect_prime(2, [], n) |> reverse
    goldbach(n, plist)
  end
  defp goldbach(n, plist) do
    p = Enum.find(plist, (fn(p) ->
      Enum.find plist, &(&1 == n - p)
    end))
    case p do
      nil -> nil
      _ -> {p, n - p}
    end
  end

  @doc ~S"""
  P41 (**) A list of Goldbach compositions.

  ## Examples
    iex> Elixir_99.goldbach_list(9, 20)
    [{3, 7}, {5, 7}, {3, 11}, {3, 13}, {5, 13}, {3, 17}]
  """
  @spec goldbach_list(integer, integer) :: list
  def goldbach_list(lower, upper) do
    [2|plist] = collect_prime(2, [], upper) |> reverse
    goldbach_list(lower, upper, [], plist) |> reverse
  end
  defp goldbach_list(2, upper, res, plist), do: goldbach_list(4, upper, res, plist)
  defp goldbach_list(lower, upper, res, plist) do
    cond do
      upper - lower < 0 -> res
      rem(lower, 2) != 0 -> goldbach_list(lower + 1, upper, res, plist)
      true ->
        case goldbach(lower, plist) do
          {a, b} -> goldbach_list(lower + 2, upper, [{a, b}|res], plist)
          _ -> goldbach_list(lower + 2, upper, res, plist)
        end
    end
  end

  @doc ~S"""
  In most cases, if an even number is written as the sum of two prime numbers,
  one of them is very small. Very rarely, the primes are both bigger than say 50.
  Try to find out how many such cases there are in the range 2..3000.

  ## Examples
    iex> Elixir_99.goldbach_list(1, 2000, 50) |> Enum.find(&(&1 == {73, 919}))
    {73, 919}
  """
  @spec goldbach_list(integer, integer, integer) :: list
  def goldbach_list(lower, upper, limit) do
    plist = collect_prime(2, [], upper)
      |> reverse
      |> Enum.filter(&(&1 > limit and &1 > 2))

    goldbach_list(lower, upper, [], plist) |> reverse
  end
end
