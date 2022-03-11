class Node
  attr_accessor :data, :left_child, :right_child

  def initialize(data, left_child = nil, right_child = nil)
    @data = data
    @right_child = right_child
    @left_child = left_child 
  end

  def has_children
    if self.left_child.nil? && self.right_child.nil?
      0
    elsif !self.left_child.nil? && !self.right_child.nil? 
      2
    else 
      1
    end
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(@array)
    
  end

  def build_tree(array)
    return Node.new(array[0]) if array.length == 1

    mid = (array.length - 1) / 2
    root = array[mid]
    left_child = build_tree(array[0..mid - 1]) unless mid == 0 
    right_child = build_tree(array[mid + 1..array.length - 1])
    Node.new(root, left_child, right_child)
  end

  def insert(node, current = @root)
    return node if current.nil?
     
    if current.data > node.data
      current.left_child = insert(node, current.left_child)
    else
      current.right_child = insert(node, current.right_child)
    end
    return current
  end

  def delete(data)
    parent = find_parent(data) 
    target = find_target(parent, data)
    
    if target.has_children == 0 
      parent.left_child == target ? parent.left_child = nil : parent.right_child = nil 
    elsif target.has_children == 1
      one_child(target)
    elsif target.has_children == 2
      two_children(target)
    end
  end

  def find(data, current=@root)
    return current if current.data == data
    return 'Not in tree' if current == nil

    if current.data > data
      find(data, current.left_child)
    else
      find(data, current.right_child)
    end
  end
  
  def insert2(node)
    current = @root
    loop do 
      if current.data > node.data
        if current.left_child == nil
          current.left_child = node
          break
        else 
          current = current.left_child
        end
      else
       if current.right_child == nil
          current.right_child = node
          break
        else 
          current = current.right_child
        end
      end
    end
    
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
    inorder_array = inorder_traverse(target)
    successor = inorder_array[inorder_array.index(target.data) + 1]
    delete(successor)
    target.data = successor
  end

  def find_target(parent, data)
    if data > parent.data
      target = parent.right_child
    elsif data == parent.data
      parent
    else
      target = parent.left_child
    end
  end


  def find_parent(data, current=@root)
    return current if current.data == data || current.left_child.data == data || current.right_child.data == data
    
    current.data < data ? find_parent(data, current.right_child) : find_parent(data, current.left_child)
  end

  def level_order_iteration
    current = @root
    queue = []
    queue.unshift(current)
    default_array = []
    
    until queue.empty?
      queue.unshift(current.left_child) unless current.left_child.nil? 
      queue.unshift(current.right_child) unless current.right_child.nil? 
      block_given? ? (yield queue.pop) : default_array << queue.pop.data
      current = queue.last
    end

    return default_array unless default_array.empty?
  end

  
  def level_order_recursion(current=@root, queue=[@root])
    return queue if current == queue.last && current.left_child.nil? && current.right_child.nil?

    queue << (current.left_child) unless current.left_child.nil?
    queue << (current.right_child) unless current.right_child.nil?
    current = queue[queue.index(current) + 1]
    level_order_recursion(current, queue)

    if block_given?
      queue.each { |node| yield(node) }
      return 
    elsif current == @root && !block_given?
      array=[]
      queue.each { |node| array << node.data }
      array
    else
      queue
    end
  end

  def inorder(current=@root)
    return nil if current.nil?
    return current if current.left_child.nil? && current.right_child.nil?

    left = inorder(current.left_child)
    root = current
    right = inorder(current.right_child)
    array = []
    array << left << root << right
    array = array.compact.flatten
    block_conditions(array, current)
  end

  def postorder(current=@root)
    return nil if current.nil?
    return current if current.left_child.nil? && current.right_child.nil?

    left = postorder(current.left_child)
    root = current
    right = postorder(current.right_child)
    array = []
    array  << left  << right << root
    array = array.compact.flatten
    block_conditions(array, current)
  end

  def preorder(current=@root, array=[])
    return nil if current.nil?
    return current if current.left_child.nil? && current.right_child.nil?

    left = preorder(current.left_child)
    root = current
    right = preorder(current.right_child)
    array = []
    array << root << left  << right 
    array = array.compact.flatten
    block_conditions(array, current)

  end

  def block_conditions(array, current)
    if block_given?
      array.each { |node| yield node}
    elsif !block_given? && current == @root
      default_array = []
      array.each { |node| default_array << node.data}
      default_array
    else
      array
    end
  end

  def inorder_traverse(current=@root)
    inorder_output = []
    return if current.nil?
    return current.data if current.left_child.nil? && current.right_child.nil?

    left =  inorder_traverse(current.left_child)
    root = current.data
    right = inorder_traverse(current.right_child)
    inorder_output << left << root << right
    return inorder_output.compact.flatten
  end

end