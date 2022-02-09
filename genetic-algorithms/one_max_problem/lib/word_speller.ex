defmodule WordSpeller do

    @word_to_spell 'helloworld'
    @offset ?a
    @behaviour GeneticAlgorithm


    # NOTES
    # A larger population is far more effective than many iterations in this module. Perhaps this is due to 
    # a smaller population resulting in more mixing between good/bad genetypes, or it's to do with local maxima

    def generate_solution() do
        0..:rand.uniform(100) |> Enum.map(fn _ -> rem(:rand.uniform(26), 26) + @offset end)
    end
    
    def crossover(lhs, rhs) do
        lhs_len = Enum.count(lhs)
        rhs_len = Enum.count(rhs)
        {bigger, smaller} = if lhs_len > rhs_len, do: {rhs_len, lhs_len}, else: {lhs_len, rhs_len}
        pivot = :rand.uniform(smaller)
        {lhs_top, lhs_bottom} = Enum.split(lhs, pivot)
        {rhs_top, rhs_bottom} = Enum.split(rhs, pivot)
        {lhs_top ++ rhs_bottom, rhs_top ++ lhs_bottom}
    end

    def mutate(soln = [h | t]) do
        if(:rand.uniform() < 0.05) do
            if :rand.uniform() > 0.5 do
                soln ++ [:rand.uniform(25)+@offset] |> Enum.shuffle()
            else
                t |> Enum.shuffle()
            end
        else
          soln
        end
    end

    def evaluate(soln) do
        evaluate_against_word(soln, @word_to_spell, 0)
    end

    defp evaluate_against_word(soln, correct_word, score)
    defp evaluate_against_word([head_char | soln_rest ], [head_char | correct_word_rest], score), 
        do: evaluate_against_word(soln_rest, correct_word_rest, score + 1)
    defp evaluate_against_word([_ | soln_rest ], [_ | correct_word_rest], score),
        do: evaluate_against_word(soln_rest, correct_word_rest, score - 1)
    defp evaluate_against_word([], [_ | correct_word_rest], score),
        do: evaluate_against_word([], correct_word_rest, score - 1)
    defp evaluate_against_word([_ | soln_rest], [], score),
        do: evaluate_against_word(soln_rest, [], score - 1)
    defp evaluate_against_word([], [], score), do: score
end