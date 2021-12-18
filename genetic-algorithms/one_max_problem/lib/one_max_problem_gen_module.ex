defmodule OneMaxProblemGenModule do
  def generate_population_factory(bitstring_length, population_size) do
    fn ->
      Enum.map(1..population_size, fn _ ->
        Enum.map(1..bitstring_length, fn _ -> Enum.random([0, 1]) end)
      end)
    end
  end

  def evaluate(member), do: Enum.sum(member)

  def mutate(member), do: if(:rand.uniform() < 0.05, do: Enum.shuffle(member), else: member)

  def crossover(parent_1, parent_2) do

    cx_point = :rand.uniform(length(parent_1))
    {parent_1_h, parent_1_t} = Enum.split(parent_1, cx_point)
    {parent_2_h, parent_2_t} = Enum.split(parent_2, cx_point)
    {parent_2_h ++ parent_1_t, parent_1_h ++ parent_2_t}
  end
end
