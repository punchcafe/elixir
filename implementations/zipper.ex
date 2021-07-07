defmodule Zipper do

  @type t :: %Zipper{focus: any, focus_ancestry: any | nil, root: any | nil}
  defstruct focus: nil, focus_ancestry: [], root: nil
  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
    %Zipper{focus: bin_tree,  root: bin_tree}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%Zipper{root: root}) do
    root
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(%Zipper{focus: %BinTree{value: value}}) do 
    value
  end


  def left(%Zipper{focus: %BinTree{left: nil}}) do
    nil
  end
  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%Zipper{focus: %BinTree{left: left} = focus} = zipper) do
    %Zipper{zipper | focus: left, focus_ancestry: [ {focus, :lhs} | zipper.focus_ancestry]}
  end


  def right(%Zipper{focus: %BinTree{right: nil}}) do
    nil
  end
  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%Zipper{focus: %BinTree{right: right} = focus} = zipper) do
    %Zipper{zipper | focus: right, focus_ancestry: [ {focus, :rhs} | zipper.focus_ancestry]}
  end

  @doc """
  Get the parent of the focus node, if any.
  """

  def up(%Zipper{focus_ancestry: []}) do
    nil
  end

  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%Zipper{focus_ancestry: [ parent | ancestors ]} = zipper) do
    %Zipper{zipper | focus: elem(parent, 0), focus_ancestry: ancestors}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(%Zipper{root: root, focus_ancestry: ancestry} = original, value) do
    path_to_value_to_change = extract_path_from_ancestry(ancestry)
    reversed_path_to_value_change = Enum.reverse(path_to_value_to_change)
    new_tree = copy_and_replace_value(root, reversed_path_to_value_change, value)
    new_focus = get_from_path(new_tree, path_to_value_to_change)
    %Zipper{ original | root: new_tree, focus: new_focus}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(%Zipper{} = zipper, left) do
    replace_tree_at(:lhs, zipper, left)
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(%Zipper{} = zipper, right) do
    replace_tree_at(:rhs, zipper, right)
  end

  defp replace_tree_at(which_hand_side, %Zipper{root: root, focus_ancestry: ancestry} = zipper, replacement_tree) 
  when which_hand_side == :rhs or which_hand_side == :lhs do
    original_path = extract_path_from_ancestry(ancestry)
    path_to_replacement_descending = original_path
    |> add_to_path(which_hand_side)
    |> Enum.reverse()
    new_tree = copy_and_replace(root, path_to_replacement_descending, replacement_tree)
    new_focus = get_from_path(new_tree, original_path)
    %Zipper{ zipper | root: new_tree, focus: new_focus}
  end

  defp extract_path_from_ancestry(ancestry) do
    Enum.map(ancestry, fn {_focus, which_hand_side} -> which_hand_side end)
  end

  defp copy_and_replace(_original, [], replacement_tree), do: replacement_tree
  defp copy_and_replace(original, [:lhs | remainder_of_path ], replacement_tree) do
    %BinTree{original | left: copy_and_replace(original.left, remainder_of_path, replacement_tree)}
  end
  defp copy_and_replace(original, [:rhs | remainder_of_path ], replacement_tree) do
    %BinTree{original | right: copy_and_replace(original.right, remainder_of_path, replacement_tree)}
  end

  defp copy_and_replace_value(original, [], replacement_value) do
    %BinTree{original | value: replacement_value}
  end
  defp copy_and_replace_value(original, [:lhs | remainder_of_path ], replacement_value) do
    %BinTree{original | left: copy_and_replace_value(original.left, remainder_of_path, replacement_value)}
  end
  defp copy_and_replace_value(original, [:rhs | remainder_of_path ] , replacement_value) do
    %BinTree{original | right: copy_and_replace_value(original.right, remainder_of_path, replacement_value)}
  end

  defp add_to_path(path, to_add_direction) do
    [to_add_direction | path]
  end

  defp get_from_path(%BinTree{} = tree, []), do: tree
  defp get_from_path(%BinTree{} = tree, [:lhs | remaining_path]), do: get_from_path(tree, remaining_path).left
  defp get_from_path(%BinTree{} = tree, [:rhs | remaining_path]), do: get_from_path(tree, remaining_path).right
end
