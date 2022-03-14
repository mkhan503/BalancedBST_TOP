# methods for level order traversal
class Node
  attr_accessor :data, :left_child, :right_child

  def initialize(data, left_child = nil, right_child = nil)
    @data = data
    @right_child = right_child
    @left_child = left_child
  end

  def children?
    if left_child.nil? && right_child.nil?
      0
    elsif !left_child.nil? && !right_child.nil?
      2
    else
      1
    end
  end
end
