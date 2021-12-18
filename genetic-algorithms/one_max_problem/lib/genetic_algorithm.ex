defmodule GeneticAlgorithm do
  #@callback(crossover(parent_1, parent_2), do: raise("unimplemented"))
  #@callback(evaluate(parent_1), do: raise("unimplemented"))
  #@callback(mutate(member), do: raise("unimplemented")) 
  #GeneticAlgorithm.evolve(OneMaxProblemGenModule, 5, OneMaxProblemGenModule.generate_population_factory(5,5))

  def evolve(module, generations, population_factory) do
    population_factory.()
    |> do_evolve(module, generations)
    |> Enum.max_by(&module.evaluate/1, &>=/2)
    |> with_evaluation(module)
  end

  defp with_evaluation(member, module), do: {member, module.evaluate(member)}

  defp do_evolve(population, module, 0), do: population

  defp do_evolve(population, module, generation) when is_integer(generation) and generation > 0 do
    population
    |> cycle(module)
    |> do_evolve(module, generation - 1)
  end


  def cycle(population, module) do
    population
    |> Enum.sort_by(&module.evaluate/1, &>=/2)
    |> do_crossover([], module)
    |> Enum.map(&module.mutate/1)
  end

  defp do_crossover([parent_1, parent_2 | rest], acc, module) do
    {child_1, child_2} = module.crossover(parent_1, parent_2)
    acc = [child_1, child_2 | acc]
    do_crossover(rest, acc, module)
  end

  defp do_crossover([remaining_single], acc, module), do: [remaining_single | acc]
  defp do_crossover([], acc, module), do: acc
end
