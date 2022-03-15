# methods for depth first traversals
module DepthFirst

  def inorder(current = @root)
    return nil if current.nil?
    return current if current.left_child.nil? && current.right_child.nil?

    array = []
    array << inorder(current.left_child) << current << inorder(current.right_child)
    array = array.compact.flatten
    if block_given?
      array.each { |node| yield node }
    else
      block_conditions(array, current)
    end
  end

  def postorder(current = @root)
    return nil if current.nil?
    return current if current.left_child.nil? && current.right_child.nil?

    array = []
    array << postorder(current.left_child) << postorder(current.right_child) << current
    array = array.compact.flatten
    if block_given?
      array.each { |node| yield node }
    else
      block_conditions(array, current)
    end
  end

  def preorder(current = @root)
    return nil if current.nil?
    return current if current.left_child.nil? && current.right_child.nil?

    left = preorder(current.left_child)
    root = current
    right = preorder(current.right_child)
    array = []
    array << root << left << right
    array = array.compact.flatten
    if block_given?
      array.each { |node| yield node }
    else
      block_conditions(array, current)
    end
  end

  def block_conditions(array, current)
    if current == @root
      default_array = []
      array.each { |node| default_array << node.data }
      default_array
    else
      array
    end
  end
end