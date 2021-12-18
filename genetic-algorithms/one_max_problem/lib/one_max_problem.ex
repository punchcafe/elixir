defmodule OneMaxProblem do
  def generate_population(bitstring_length, population_size) do
    Enum.map(1..population_size, fn _ ->
      Enum.map(1..bitstring_length, fn _ -> Enum.random([0, 1]) end)
    end)
  end

  def evaluate_population(population), do: Enum.sort_by(population, &evaluate_member/1, &>=/2)

  def evaluate_member(member), do: Enum.sum(member)

  def evolve(bitstring_length, population_size, generations) do
    bitstring_length
    |> generate_population(population_size)
    |> do_evolve(bitstring_length, generations)
    |> Enum.max_by(&evaluate_member/1, &>=/2)
  end

  def mutate(population = [member | _]) when is_list(member), do: Enum.map(population, &mutate/1)

  def mutate(member), do: if(:rand.uniform() < 0.05, do: Enum.shuffle(member), else: member)

  def do_evolve(population, bitstring_length, 0), do: population

  def do_evolve(population, bitstring_length, generations) when generations > 0,
    do: population |> cycle(bitstring_length) |> do_evolve(bitstring_length, generations - 1)

  def cycle(population, bitstring_length) do
    population
    |> evaluate_population()
    |> crossover([], bitstring_length)
    |> mutate()
  end

  def crossover([parent_1, parent_2 | rest], acc, bitstring_length) do
    cx_point = :rand.uniform(bitstring_length)
    {parent_1_h, parent_1_t} = Enum.split(parent_1, cx_point)
    {parent_2_h, parent_2_t} = Enum.split(parent_2, cx_point)
    acc = [parent_2_h ++ parent_1_t, parent_1_h ++ parent_2_t | acc]
    crossover(rest, acc, bitstring_length)
  end

  def crossover([single], acc, _bitstring_length), do: [single | acc]
  def crossover([], acc, _bitstring_length), do: acc
end
