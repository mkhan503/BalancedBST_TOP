# methods for tree class
class Tree
  include DepthFirst
  include LevelOrder

  attr_accessor :root

  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(@array)
  end

  def build_tree(array)
    return Node.new(array[0]) if array.length == 1

    mid = (array.length - 1) / 2
    root = array[mid]
    left_child = build_tree(array[0..mid - 1]) unless mid.zero?
    right_child = build_tree(array[mid + 1..array.length - 1])
    Node.new(root, left_child, right_child)
  end

  def insert(value, current = @root)
    return Node.new(value) if current.nil?

    if current.data > value
      current.left_child = insert(value, current.left_child)
    else
      current.right_child = insert(value, current.right_child)
    end
    current
  end

  def delete(data)
    parent = find_parent(data)
    target = find_target(parent, data)

    if target.children?.zero?
      parent.left_child == target ? parent.left_child = nil : parent.right_child = nil
    elsif target.children? == 1
      one_child(target)
    elsif target.children? == 2
      two_children(target)
    end
    target 
  end

  def one_child(target)
    if target.left_child.nil?
      target.data = target.right_child.data
      target.right_child = nil
    else
      target.data = target.left_child.data
      target.left_child = nil
    end
  end

  def two_children(target)
    inorder_array = inorder(target)
    successor = inorder_array[inorder_array.index(target) + 1]
    successor = nil
    target.data = successor
  end

  def find_target(parent, data)
    if data > parent.data
      parent.right_child
    elsif data == parent.data
      parent
    else
      parent.left_child
    end
  end

  def find_parent(data, current = @root)
    return current if current.data == data 
    unless current.left_child.nil?
      return current if  current.left_child.data == data 
    end
    unless current.right_child.nil?
      return current if current.right_child.data == data
    end

    if current.data < data
       find_parent(data, current.right_child) unless current.right_child.nil?
    else
       find_parent(data, current.left_child) unless current.left_child.nil?
    end
  end

  def find(data, current = @root)
    return current if current.data == data
    return 'Not in tree' if current.nil?

    if current.data > data
      find(data, current.left_child)
    else
      find(data, current.right_child)
    end
  end

  def height(node = @root, node_height = 0)
    node = find(node.data) if node_height == 0 
    return nil if node.nil?
    return node_height if node.left_child.nil? && node.right_child.nil?

    node_height += 1
    left = height(node.left_child, node_height) unless node.left_child.nil?
    right = height(node.right_child, node_height) unless node.right_child.nil?
    left.to_i > right.to_i ? left : right
  end

  def depth(target = @root, current = @root, depth = 0)
    return depth if current.data == target.data

    if current.data < target.data
      current = current.right_child unless current.right_child.nil?
    else
      current = current.left_child unless current.left_child.nil?
    end
    depth(target, current, depth + 1)
  end

  def balanced?(current = @root)
    left_subtree = current.left_child
    right_subtree = current.right_child
    diff = (height(left_subtree).to_i - height(right_subtree).to_i).abs
    (diff <= 1)
  end

  def rebalance
    array = inorder
    @root = build_tree(array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
