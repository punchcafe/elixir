defmodule MergeSort do
    
    def merge_sort(unsorted_list) when is_list(unsorted_list) and length(unsorted_list) <= 1 do
        unsorted_list
    end

    def merge_sort(unsorted_list) do
        lhs = merge_sort(Enum.slice(unsorted_list, 0,div(length(unsorted_list),2)))
        rhs = merge_sort(Enum.slice(unsorted_list, div(length(unsorted_list),2),length(unsorted_list)))
        merge_sorted_lists(lhs, rhs, [])
    end

    def merge_sorted_lists(lhs, rhs, acc) when length(lhs) == 0 do 
        acc++rhs
    end

    def merge_sorted_lists(lhs, rhs, acc) when length(rhs) == 0 do 
        acc++lhs
    end

    def merge_sorted_lists(lhs, rhs, acc) do
        [lhs_head|lhs_tail] = lhs
        [rhs_head|rhs_tail] = rhs
        if(lhs_head < rhs_head) do
            merge_sorted_lists(lhs_tail, rhs, acc++[lhs_head])
        else
            merge_sorted_lists(lhs, rhs_tail, acc++[rhs_head])
        end
    end
end

IO.inspect(MergeSort.merge_sort([1,5,4,7,1,1,3]))