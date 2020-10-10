defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(_, size) when size < 0, do: raise(ArgumentError)
  def largest_product("", size) when size > 0, do: raise(ArgumentError)
  def largest_product("", _), do: 1
  def largest_product(_, 0), do: 1

  def largest_product(number_string, size) do
    preprocess(number_string)
    |> split(size)
    |> calculate_product_sum
    |> Enum.max()
  end

  defp preprocess(number_string) do
    number_string
    |> String.graphemes()
    |> Enum.map(fn x ->
      {intVal, _} = Integer.parse(x)
      intVal
    end)
  end

  defp split(list, size) when length(list) < size, do: raise(ArgumentError)
  defp split(list, size) do
    Enum.chunk_every(list, size, 1, :discard)
    |> Enum.filter(fn x -> not (0 in x) end)
  end

  defp calculate_product_sum([]), do: [0]
  defp calculate_product_sum(sublist) do
    Enum.map(sublist, fn serie ->
      Enum.reduce(serie, 1, fn x, acc ->
        acc * x
      end)
    end)
  end
end
