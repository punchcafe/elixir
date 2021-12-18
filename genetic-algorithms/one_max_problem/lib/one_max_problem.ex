defmodule OneMaxProblem do
  def generate_population(bitstring_length, population_size) do
    Enum.map(0..population_size, fn _ ->
      Enum.map(0..bitstring_length, fn _ -> Enum.random([0, 1]) end)
    end)
  end

  def evaluate_member(member), do: Enum.sum(member)
end
